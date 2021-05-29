class ApiError {
  int statusCode;
  bool error;
  String errorCode;
  dynamic message;

  ApiError({this.statusCode, this.error, this.errorCode, this.message});

  ApiError.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    error = json['error'];
    errorCode = json['error_code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['error'] = this.error;
    data['error_code'] = this.errorCode;
    data['message'] = this.message;
    return data;
  }
}