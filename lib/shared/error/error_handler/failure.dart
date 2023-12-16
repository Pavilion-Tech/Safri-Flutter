class Failure {
  int? code; // 200, 201, 400, 303..500 and so on
  String message; // error , success
  TypeMsg type;

  Failure(this.code, this.message, [this.type = TypeMsg.error]);

  @override
  String toString() {
    return 'Failure{code: $code, message: $message, type: $type}';
  }

  void printInfo(String from) {
    print('from => $from : Failure{code: $code, message: $message, type: $type}');
  }
}

enum TypeMsg { ok, error, warning }
