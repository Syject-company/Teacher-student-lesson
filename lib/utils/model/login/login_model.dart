class LoginModel {
  String deviceToken;
  String token;
  SocialProvider provider;

  LoginModel({
    required this.deviceToken,
    required this.token,
    required this.provider,
  });
  Map<String, dynamic> toJson() => {
        "deviceToken": deviceToken,
        "token": token,
        "provider": provider == SocialProvider.Facebook ? 'Facebook' : 'Google'
      };
}

enum SocialProvider { Google, Facebook }
