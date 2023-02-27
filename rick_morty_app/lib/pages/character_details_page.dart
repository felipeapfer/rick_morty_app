import 'package:flutter/material.dart';
import 'package:rick_morty_app/models/character.dart';

class CharacterDetails extends StatelessWidget {
  final Character c;
  const CharacterDetails({super.key, required this.c});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    if (c.status == 'Alive') {
      statusColor = Colors.green;
    } else if (c.status == 'Dead') {
      statusColor = Colors.red;
    } else {
      statusColor = Colors.grey;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(c.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: statusColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(c.status),
                ],
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Species:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Type:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(c.status),
                      Text(c.species),
                      Text(c.type),
                    ],
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Gender:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Origin:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Location:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(c.gender),
                      Text(c.origin.name),
                      Text(c.location.name),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              ExpansionTile(
                  title:
                      Text('Total Episodes  - ${c.episode.length.toString()}'),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: c.episode.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(c.episode[index]),
                        );
                      },
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
