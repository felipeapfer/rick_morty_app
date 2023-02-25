import 'package:flutter/material.dart';
import 'package:rick_morty_app/models/character.dart';

class CharacterDetails extends StatelessWidget {
  final Character c;
  const CharacterDetails({super.key, required this.c});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(c.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            Center(
              child: CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage(c.image),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text(
                  'Status: ',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  c.status.toString(),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.normal),
                )
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text(
                  'Species: ',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  c.species.toString(),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.normal),
                )
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text(
                  'Gender: ',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  c.gender.toString(),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.normal),
                )
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text(
                  'Type: ',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  c.type.toString(),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.normal),
                )
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text(
                  'Origin: ',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  c.origin.name.toString(),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.normal),
                )
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text(
                  'Last Know Location: ',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  c.location.name.toString(),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.normal),
                )
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text(
                  'Total Episodes: ',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  c.episode.length.toString(),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.normal),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
