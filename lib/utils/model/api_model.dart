class UserLogin {
  String email;
  String password;

  UserLogin({required this.email, required this.password});

  Map<String, dynamic> toDatabaseJson() =>
      {"email": this.email, "password": this.password};
}

class UserRecoveryEmail {
  String email_recovery;

  UserRecoveryEmail({required this.email_recovery});

  Map<String, dynamic> toDatabaseJson() => {"email": this.email_recovery};
}

class UserReSetPassword {
  String new_password;
  String re_new_password;
  String current_password;

  UserReSetPassword(
      {required this.new_password,
      required this.re_new_password,
      required this.current_password});

  Map<String, dynamic> toDatabaseJson() => {
        "new_password": this.re_new_password,
        "re_new_password": this.new_password,
        "current_password": this.current_password
      };
}

class UserUpdateData {
  String gender;
  String gender_other;
  String username;
  String regionId;
  int year_of_birth;

  UserUpdateData({
    required this.gender,
    required this.gender_other,
    required this.username,
    required this.regionId,
    required this.year_of_birth,
  });

  Map<String, dynamic> toDatabaseJson() => {
        "username": this.username,
        "gender": this.gender,
        "gender_other": this.gender_other,
        "region": {"uuid": this.regionId},
        "year_of_birth": this.year_of_birth
      };
}

class Region {
  Region({
    required this.name,
    required this.uuid,
    required this.points,
  });

  String name;
  String uuid;
  String points;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        name: json["name"],
        uuid: json["uuid"],
        points: json["points"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "uuid": uuid,
        "points": points,
      };
}

class ChildRegister {
  String name;
  String email;
  String password;
  String childImageId;
  String birthDate;

  ChildRegister({
    required this.name,
    required this.email,
    required this.password,
    required this.childImageId,
    required this.birthDate,
  });

  Map<String, dynamic> toDatabaseJson() => {
        "name": this.name,
        "email": this.email,
        "password": this.password,
        "childImageId": this.childImageId,
        "birthDate": this.birthDate,
      };
}

class UserRegister {
  String name;
  String email;
  String password;
  String country;

  UserRegister({
    required this.name,
    required this.email,
    required this.password,
    required this.country,
  });

  Map<String, dynamic> toDatabaseJson() => {
        "name": this.name,
        "email": this.email,
        "password": this.password,
        "country": this.country,
      };
}

class Token {
  String firstName;
  String userId;
  List<String> roles;
  String refreshToken;
  String accessToken;
  String expiredRefresh;
  Token({
    required this.firstName,
    required this.userId,
    required this.roles,
    required this.refreshToken,
    required this.accessToken,
    required this.expiredRefresh,
  });
  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      firstName: json["firstName"],
      userId: json["userId"],
      roles: List<String>.from(json["roles"].map((x) => x)),
      refreshToken: json['refreshToken'],
      accessToken: json['jwt'],
      expiredRefresh: json['expiredRefresh'],
    );
  }
}

class UserID {
  String uid;
  UserID({required this.uid});
  factory UserID.fromJson(Map<String, dynamic> json) {
    return UserID(uid: json['userId']);
  }
}
