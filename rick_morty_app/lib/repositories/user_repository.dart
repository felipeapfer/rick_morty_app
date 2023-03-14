import 'dart:convert';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty_app/models/user.dart';
import 'package:http/http.dart' as http;

class RadarException implements Exception {
  late String message;
  RadarException(this.message);
}

class RadarAuthExecption extends RadarException {
  String type;

  RadarAuthExecption(this.type, message) : super(message);
}

class UserRepository extends ChangeNotifier {
  bool isLoggedIn = false;
  bool needsConfirmation = false;
  bool needsPasswordReset = false;
  String? token = "";

  late User _user;
  late CognitoUserPool userPool;
  late CognitoUserSession? session;
  late CognitoCredentials credentials;

  User get user => _user;

  UserRepository({
    required String userPoolId,
    required String clientId,
  }) {
    userPool = CognitoUserPool(userPoolId, clientId);
  }

  Future<void> signUp(email, password) async {
    try {
      await userPool.signUp(email, password);
    } on CognitoUserException catch (e) {
      debugPrint(e.message);
    } on CognitoClientException catch (e) {
      debugPrint(e.message);
    }
  }

  Future<bool> resendConfirmationCode(email) async {
    final cognitoUser = CognitoUser(email, userPool);
    final String status;
    try {
      status = await cognitoUser.resendConfirmationCode();
      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  singIn(email, password) async {
    final cognitoUser = CognitoUser(email, userPool);
    //cognitoUser.setAuthenticationFlowType('CUSTOM_AUTH');
    final authDetails = AuthenticationDetails(
      username: email,
      password: password,
    );
    try {
      session = await cognitoUser.authenticateUser(authDetails);
      isLoggedIn = true;
      //token = session!.getAccessToken().getJwtToken();
      token = session!.getIdToken().getJwtToken();
      needsConfirmation = false;
      try {
        final response = await http.get(
            Uri.parse(
              'https://staging-api.radaresportivo.com/users/me',
            ),
            headers: {'Authorization': token!});
        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);
          _user = User.fromJson(json);
        }
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
      notifyListeners();
    } on CognitoUserNewPasswordRequiredException catch (e) {
      // handle New Password challenge
      throw RadarAuthExecption("RESET_PASSWORD",
          "Por motivos de segurança uma nova senha precisa ser cadastrada. Por favor verifique o seu e-mail cadastrado.");
    } on CognitoUserConfirmationNecessaryException catch (e) {
      // handle User Confirmation Necessary
      throw RadarAuthExecption('NEEDS_USER_CONFIRMATION',
          "Usuário não confirmado. Por favor confirme seu email!");
    } on CognitoClientException catch (e) {
      switch (e.name) {
        case 'UserNotFoundException':
          debugPrint("Email não cadastrado!");
          throw RadarAuthExecption('INVALID_EMAIL', "Email não cadastado!");
        case 'NotAuthorizedException':
          debugPrint("Senha Incorreta!");
          throw RadarAuthExecption(
              'INVALID_PASSWORD', "Senha incorreta! Tente Novamente");
        case null:
          throw RadarAuthExecption('UNKNOWN_ERROR',
              "Por favor verifique sua conexão com a Internet.");
      }
      debugPrint(e.toString());
    } on Exception catch (e) {
      throw RadarException('Erro inesperado');
    }

    //Call https://api.radaresportivo.com/users/me to load user object.
    //Understand how to call using token given
    try {} on Exception catch (e) {}
  }

  Future<bool> changePassword(oldPassword, newPassword) async {
    if (isLoggedIn) {
      final cognitoUser = CognitoUser(user.email, userPool);
      try {
        await cognitoUser.changePassword('oldPassword', 'newPassword');
        return true;
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
    }
    return false;
  }

  updateUserName(newName) async {
    if (isLoggedIn) {
      try {
        final response = await http.put(
            Uri.parse(
              'https://staging-api.radaresportivo.com/users/me',
            ),
            headers: {
              'Authorization': token!
            },
            body: {
              'name': newName,
            });
        if (response.statusCode == 200) {
          user.name = newName;
          notifyListeners();
        }
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  forgotPassword(email) async {
    final cognitoUser = CognitoUser(email, userPool);
    try {
      await cognitoUser.forgotPassword();
    } catch (e) {
      debugPrint(e.toString());
      //Treat Email does not exist execpetion
    }
  }

  signOut() async {
    if (isLoggedIn) {
      final cognitoUser = CognitoUser(user.email, userPool);
      try {
        await cognitoUser.signOut();
        isLoggedIn = false;
        needsConfirmation = false;
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
      notifyListeners();
    }
  }
}
