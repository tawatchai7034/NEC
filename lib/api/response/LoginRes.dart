class LoginResponse {
  String? username;
  String? password;
  String? defaultOption;
  String? errorMessage;

  LoginResponse(
      {this.username, this.password, this.defaultOption, this.errorMessage});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    username = json['Username'];
    password = json['Password'];
    defaultOption = json['DefaultOption'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Username'] = this.username;
    data['Password'] = this.password;
    data['DefaultOption'] = this.defaultOption;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}