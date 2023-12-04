class ErrorMsg {
  String? msg;
  ErrorMsg(this.msg);
  ErrorMsg.fromJson(Map<String, dynamic> json) {
    msg = json["msg"];
  }
}
