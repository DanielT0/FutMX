
<!DOCTYPE html>

<head>
    <!-- Add meta tags for mobile and IE -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
</head>

<body>
    <!-- Set up a container element for the button -->
    <div id="paypal-button-container"></div>

    <!-- Include the PayPal JavaScript SDK -->
    <script src="https://www.paypal.com/sdk/js?client-id=sb&currency=USD"></script>

    <script>
        // Render the PayPal button into #paypal-button-container
        paypal.Buttons({

            // Set up the transaction
            createOrder: function(data, actions) {
                return actions.order.create({
                    purchase_units: [{
                        amount: {
                            value: '0.01'
                        }
                    }]
                });
            },

            // Finalize the transaction
            onApprove: function(data, actions) {
                return actions.order.capture().then(function(details) {
                    // Show a success message to the buyer
                    alert('Transaction completed by ' + details.payer.name.given_name + '!');
                });
            }


        }).render({
          env: 'sanbox', // Optional: specify 'sandbox' environment
          client: {
            sandbox:    'xxxxxxxxx',
            production: 'xxxxxxxxx'
          },
          commit: true, // Optional: show a 'Pay Now' button in the checkout flow
          payment: function (data, actions) {
            return actions.payment.create({
              payment: {
                transactions: [
                  {
                    amount: {
                      total: '1.00',
                      currency: 'USD'
                    }
                  }
                ]
              }
            });
          },
          onAuthorize: function (data, actions) {
            // Get the payment details
            return actions.payment.get()
              .then(function (paymentDetails) {
                // Show a confirmation using the details from paymentDetails
                // Then listen for a click on your confirm button
                document.querySelector('#confirm-button')
                  .addEventListener('click', function () {
                    // Execute the payment
                    return actions.payment.execute()
                      .then(function () {
                        // Show a success page to the buyer
                      });
                  });
              });
          }
        }, '#paypal-button-container');
    </script>
</body>