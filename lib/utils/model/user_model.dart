class User {
  final String firstName;
  final String userId;
  final List<String> roles;
  final String? email;
  final String? password;
  final String tokenRefresh;
  final String tokenAccess;
  final String refreshExp;

  User(
      {required this.userId,
      required this.firstName,
      required this.roles,
      this.email,
      this.password,
      required this.tokenRefresh,
      required this.tokenAccess,
      required this.refreshExp});

  factory User.fromDatabaseJson(Map<String, dynamic> data) => User(
        firstName: data["firstName"],
        userId: data["userId"],
        roles: List<String>.from(data["roles"].map((x) => x)),
        tokenRefresh: data['refreshToken'],
        tokenAccess: data['jwt'],
        refreshExp: data['expiredRefresh'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        "firstName": firstName,
        "userId": userId,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "refreshToken": this.tokenRefresh,
        "jwt": this.tokenAccess,
        "expiredRefresh": this.refreshExp
      };
}
