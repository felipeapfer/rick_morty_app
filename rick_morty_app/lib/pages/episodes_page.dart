import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/repositories/episodes_repository.dart';

import '../models/episode.dart';

class EpisodesPage extends StatefulWidget {
  const EpisodesPage({super.key});

  @override
  State<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  late List<Episode> episodesList;
  late EpisodeRepository er;

  @override
  Widget build(BuildContext context) {
    er = context.watch<EpisodeRepository>();
    return Scaffold(
        backgroundColor: const Color(0xFFE7E7E7),
        appBar: AppBar(
          backgroundColor: const Color(0xFF3D3D3D),
          centerTitle: true,
          title: const Text('Episodes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            er.isLoading
                ? const CircularProgressIndicator()
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int episode) {
                      return ListTile(
                        leading: SizedBox(
                          width: 40,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Text(
                              er.episodes[episode].id.toString(),
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        title: Row(
                          children: [
                            Text(
                              er.episodes[episode].name,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (_, ___) => const Divider(),
                    itemCount: er.episodes.length,
                  ),
          ],
        )));
  }
}
