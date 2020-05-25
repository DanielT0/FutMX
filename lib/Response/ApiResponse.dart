class ApiResponse<T> {
  Status status;
  T data;
  String message;

  ApiResponse.loading(this.message) : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  ApiResponse.error() {
    this.message='Hubo un error en la comunicación con el servidor. \n Revisa tu conexión a internet y recarga de nuevo esta sección';
    status = Status.ERROR;
  }

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }
