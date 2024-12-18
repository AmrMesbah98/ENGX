class FinalToken {
  String? token;
  FinalToken({required this.token});
  FinalToken.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}
