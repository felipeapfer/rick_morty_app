import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/repositories/characteres_repository.dart';
import 'package:rick_morty_app/repositories/episodes_repository.dart';
import 'package:rick_morty_app/repositories/user_repository.dart';
import 'package:rick_morty_app/rickApp.dart';
import 'package:rick_morty_app/services/date_service.dart';
import 'package:rick_morty_app/shared/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserRepository(
            userPoolId: Config.AWS_USER_POOL_ID,
            clientId: Config.AWS_USER_POOL_CLIENT_ID,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => EpisodeRepository(),
        ),
        ChangeNotifierProvider(
          create: (context) => CharacterRepository(),
        ),
        ChangeNotifierProvider(
          create: (context) => DateService(
            er: context.read<EpisodeRepository>(),
          ),
        ),
      ],
      child: const RickApp(),
    ),
  );
}
