import 'dart:async';
import 'dart:convert';
import 'package:tutor/app_state.dart';
import 'package:tutor/utils/model/login/login_model.dart';
import 'package:tutor/utils/model/user_model.dart';
import 'package:tutor/utils/model/api_model.dart';
import 'package:tutor/services/api_connection.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  final String _userAccessTokenKey = "userAccessToken";
  final String _userRefreshTokenKey = "userRefreshToken";
  final String _userRefreshExpKey = "userRefreshExp";
  final String _user = "user";
  final storage = new FlutterSecureStorage();

  Future<User> authenticate(
      {required bool isParent,
      required String email,
      required String password}) async {
    UserLogin userLogin = UserLogin(email: email, password: password);

    Token token = await getToken(userLogin, isParent);
    FFAppState().firstName = token.firstName;
    User user = User(
      firstName: token.firstName,
      userId: token.userId,
      roles: token.roles,
      email: email,
      password: password,
      tokenRefresh: token.refreshToken,
      tokenAccess: token.accessToken,
      refreshExp: token.expiredRefresh,
    );
    return user;
  }

  Future<String> register({
    required String name,
    required String email,
    required String password,
    required String country,
  }) async {
    UserRegister userReg = UserRegister(
      email: email,
      password: password,
      country: country,
      name: name,
    );
//     UserLogin userLogin = UserLogin(email: email, password: password);
// bool isParent;
// Token token = await getToken(userLogin, isParent=true);

    var errorMessage = await createUser(userReg);
    return errorMessage ?? "";
  }

  Future<String> childRegisterStart({
    required String email,
    required String name,
    required String password,
    required String childImageId,
    required String birthDate,
  }) async {
    String? accessToken = await getAccessToken();
    ChildRegister childReg = ChildRegister(
      email: email,
      password: password,
      name: name,
      childImageId: childImageId,
      birthDate: birthDate.replaceFirst(RegExp(' '), 'T') + 'Z',
    );

    var errorMessage = await createChild(childReg, accessToken);
    return errorMessage ?? "";
  }

  Future<void> saveUser({required User user}) {
    return storage.write(key: _user, value: json.encode(user.toDatabaseJson()));
  }

  Future<void> saveAccessToken({required String tokenAccess}) {
    return storage.write(key: _userAccessTokenKey, value: tokenAccess);
  }

  Future<void> saveRefreshToken({required String tokenRefresh}) {
    return storage.write(key: _userRefreshTokenKey, value: tokenRefresh);
  }

  Future<void> saveRefreshExp({required User user}) {
    return storage.write(
        key: _userRefreshExpKey, value: user.refreshExp.toString());
  }

  Future<void> deleteToken() {
    return storage.delete(key: _userAccessTokenKey).then((value) => storage
        .delete(key: _userRefreshTokenKey)
        .then((value) => storage.delete(key: _userRefreshExpKey)));
  }

  Future<bool> hasToken() async {
    return await getAccessToken() != null;
  }

  Future<bool> isValidToken() async {
    return await getTokenExp().then((value) {
      var b = value?.replaceAll(RegExp('[T]|[Z]'), ' ') ??
          '2000-09-12T13:47:40.5658801Z';
      List<String> c = b.split("")
        ..removeLast()
        ..removeLast();
      return DateTime.parse(c.join()).isAfter(DateTime.now());
    });
  }

  Future<Token> refreshToken() async {
    final String? accessToken = await getAccessToken();
    final String? refreshToken = await getRefreshToken();
    Future<Token> token = refreshTkn(accessToken, refreshToken);
    return token;
  }

  Future<User> getUser() async {
    print(
        '111${User.fromDatabaseJson(json.decode(await storage.read(key: _user) ?? '{}')).userId}');
    return User.fromDatabaseJson(
        json.decode(await storage.read(key: _user) ?? '{}'));
  }

  Future<String?> getTokenExp() {
    return storage.read(key: _userRefreshExpKey);
  }

  Future<String?> getAccessToken() {
    return storage.read(key: _userAccessTokenKey);
  }

  Future<String?> getRefreshToken() {
    return storage.read(key: _userRefreshTokenKey);
  }

  Future<String?> getCode({required String email, required int parentIndex}) {
    return getForgotPassLetter(email, parentIndex);
  }

  Future<String?> sendNewPassword(
      {required String newPassword,
      required String email,
      required String code,
      required int parentIndex}) {
    return sendNewPass(newPassword, email, code, parentIndex);
  }

  Future<User> sendSocialToken({
    required String token,
    required SocialProvider provider,
    required String deviceToken,
  }) =>
      sendSocialLoginToken(LoginModel(
        deviceToken: deviceToken,
        provider: provider,
        token: token,
      ));
}
