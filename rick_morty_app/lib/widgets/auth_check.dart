//import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/pages/home_page.dart';
import 'package:rick_morty_app/pages/login_page.dart';
import 'package:rick_morty_app/repositories/user_repository.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => AuthCheckState();
}

class AuthCheckState extends State<AuthCheck> {
  bool isConfigured = false;
  @override
  initState() {
    super.initState();
    _configureAmplify();
  }

  _configureAmplify() async {}

  /*  StreamSubscription<HubEvent> hubSubscription =
      Amplify.Hub.listen([HubChannel.Auth], (hubEvent) {
    switch (hubEvent.eventName) {
      case 'SIGNED_IN':
        safePrint('USER IS SIGNED IN');
        break;
      case 'SIGNED_OUT':
        safePrint('USER IS SIGNED OUT');
        break;
      case 'SESSION_EXPIRED':
        safePrint('SESSION HAS EXPIRED');
        break;
      case 'USER_DELETED':
        safePrint('USER HAS BEEN DELETED');
        break;
      default:
        safePrint(hubEvent.eventName);
        break;
    }
  });
 */
  @override
  Widget build(BuildContext context) {
    UserRepository auth = Provider.of<UserRepository>(context);
    if (auth.isLoggedIn) {
      return const HomePage();
    } else {
      return const LoginPage();
    }
  }

  loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
