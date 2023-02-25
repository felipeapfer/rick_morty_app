import 'package:flutter/material.dart';
import 'package:rick_morty_app/models/episode.dart';

class EpisodeDetails extends StatelessWidget {
  final Episode ep;
  const EpisodeDetails({super.key, required this.ep});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ep.episode),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    ep.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                const Text(
                  'Air Date: ',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange),
                ),
                Text(ep.airDate.toString()),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                const Text(
                  'Created at: ',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange),
                ),
                Text(ep.created.toString()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
