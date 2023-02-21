import 'package:flutter/material.dart';
import 'package:rick_morty_app/services/episode_service.dart';

class EpisodesPage extends StatefulWidget {
  const EpisodesPage({super.key});

  @override
  State<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  final episodes = EpisodeService.episodes;

  @override
  Widget build(BuildContext context) {
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.075,
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int episode) {
                  return ListTile(
                    leading: SizedBox(
                      width: 40,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                          episodes[episode].id.toString(),
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
                          episodes[episode].name,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (_, ___) => Divider(),
                itemCount: episodes.length),
          ],
        ),
      ),
    );
  }
}
