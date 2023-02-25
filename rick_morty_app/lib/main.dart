import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/repositories/characteres_repository.dart';
import 'package:rick_morty_app/repositories/episodes_repository.dart';
import 'package:rick_morty_app/rickApp.dart';
import 'package:rick_morty_app/services/date_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => EpisodeRepository(),
        ),
        ChangeNotifierProvider(
          create: (context) => CharacterRepository(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              DateService(er: context.read<EpisodeRepository>()),
        ),
      ],
      child: const RickApp(),
    ),
  );
}
