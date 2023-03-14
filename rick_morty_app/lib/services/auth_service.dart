import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rick_morty_app/shared/config.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
// Sign up a new user
  Future<String> signUp(String email, String password) async {
    final url = 'https://cognito-idp.${Config.AWS_REGION}.amazonaws.com/';
    final queryParameters = {
      'Action': 'SignUp',
      'ClientId': Config.AWS_USER_POOL_CLIENT_ID,
      'Username': email,
      'Password': password,
      'UserAttributes.1.Name': 'email',
      'UserAttributes.1.Value': email,
    };
    final authHeaders = {
      'origin': 'https://radaresportivo.com',
      'referer': 'https://radaresportivo.com',
    };
    final response = await http.post(Uri.parse(url),
        headers: authHeaders, body: queryParameters);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['UserSub'];
    } else {
      throw Exception('Failed to sign up user: ${response.statusCode}');
    }
  }
}

/* Future<void> logIn(String username, String password) async {
  final url = 'https://cognito-idp.${Config.AWS_REGION}.amazonaws.com/';
  final authString = '${Config.AWS_REGION}:$_clientSecret';
  final authHeaders = {
    'Content-Type': 'application/x-amz-json-1.1',
    'Authorization': 'Basic ${base64Encode(utf8.encode(authString))}',
  };
  final body = jsonEncode({
    'AuthParameters': {'USERNAME': username, 'PASSWORD': password},
    'ClientId': _clientId,
    'AuthFlow': 'USER_PASSWORD_AUTH',
  });
  final response =
      await http.post(Uri.parse(url), headers: authHeaders, body: body);
  if (response.statusCode == 200) {
    print(jsonDecode(response.body)['AuthenticationResult']['IdToken']);
  } else {
    throw Exception('Failed to log in user: ${response.statusCode}');
  }
} */
/* 
// Confirm a new user's email address
Future<void> confirmUser(String username, String confirmationCode) async {
  final url = 'https://cognito-idp.$_region.amazonaws.com/';
  final queryParameters = {
    'Action': 'ConfirmSignUp',
    'ClientId': _clientId,
    'Username': username,
    'ConfirmationCode': confirmationCode,
  };
  final response = await http.post(Uri.parse(url), body: queryParameters);
  if (response.statusCode != 200) {
    throw Exception('Failed to confirm user: ${response.statusCode}');
  }
}

// Resend a confirmation code to a user's email address
Future<void> resendConfirmationCode(String username) async {
  final url = 'https://cognito-idp.$_region.amazonaws.com/';
  final queryParameters = {
    'Action': 'ResendConfirmationCode',
    'ClientId': _clientId,
    'Username': username,
  };
  final response = await http.post(Uri.parse(url), body: queryParameters);
  if (response.statusCode != 200) {
    throw Exception(
        'Failed to resend confirmation code: ${response.statusCode}');
  }
} */

// Log in an existing user

/*
Future<void> changePassword(
    String username, String oldPassword, String newPassword) async {
  final url = 'https://cognito-idp.$_region.amazonaws.com/';
  final accessToken = await _getAccessToken(username, oldPassword);
  final headers = {
    'Content-Type': 'application/x-amz-json-1.1',
    'Authorization': 'Bearer $accessToken',
  };
  final body = jsonEncode({
    'PreviousPassword': oldPassword,
    'ProposedPassword': newPassword,
  });
  final queryParameters = {
    'Action': 'ChangePassword',
    'AccessToken': accessToken,
  };
  final response = await http.post(Uri.parse(url),
      headers: headers, body: body, queryParameters: queryParameters);
  if (response.statusCode != 200) {
    throw Exception('Failed to change password: ${response.statusCode}');
  }
}

// Log out the current user
Future<void> logOut(String accessToken) async {
  final url = 'https://cognito-idp.$_region.amazonaws.com/';
  final queryParameters = {
    'Action': 'GlobalSignOut',
    'AccessToken': accessToken,
  };
  final response = await http.post(Uri.parse(url), body: queryParameters);
  if (response.statusCode != 200) {
    throw Exception('Failed to log out user: ${response.statusCode}');
  }
}

// Helper function to get an access token for a user
Future<String> _getAccessToken(String username, String password) async {
  final url = 'https://cognito-idp.$_region.amazonaws.com/';
  final authString = '$_clientId:$_clientSecret';
  final authHeaders = {
    'Content-Type': 'application/x-amz-json-1.1',
    'Authorization': 'Basic ${base64Encode(utf8.encode(authString))}',
  };
  final body = jsonEncode({
    'AuthParameters': {'USERNAME': username, 'PASSWORD': password},
    'ClientId': _clientId,
    'AuthFlow': 'USER_PASSWORD_AUTH',
  });
  final response =
      await http.post(Uri.parse(url), headers: authHeaders, body: body);
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['AuthenticationResult']['AccessToken'];
  } else {
    throw Exception('Failed to get access token: ${response.statusCode}');
  }
} */
