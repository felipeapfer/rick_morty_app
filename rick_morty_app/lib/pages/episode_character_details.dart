import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/models/character.dart';
import 'package:rick_morty_app/repositories/characteres_repository.dart';

class EpisodeCharacterDetails extends StatefulWidget {
  final int id;
  const EpisodeCharacterDetails({super.key, required this.id});

  @override
  State<EpisodeCharacterDetails> createState() =>
      _EpisodeCharacterDetailsState();
}

class _EpisodeCharacterDetailsState extends State<EpisodeCharacterDetails> {
  late Character c;
  late CharacterRepository cr;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  _loadData() async {
    _loadCharacteres();
  }

  _refreshScreen() {
    setState(() {
      isLoading = false;
    });
  }

  _loadCharacteres() async {
    c = await cr.getCharById(widget.id);
    _refreshScreen();
  }

  @override
  Widget build(BuildContext context) {
    cr = context.watch<CharacterRepository>();
    Color statusColor;
    if (!isLoading) {
      if (c.status == 'Alive') {
        statusColor = Colors.green;
      } else if (c.status == 'Dead') {
        statusColor = Colors.red;
      } else {
        statusColor = Colors.grey;
      }
    } else {
      statusColor = Colors.grey;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isLoading
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Center(
                          child: Text(c.name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold))),
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
                              Text('Species:',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text('Location:',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(c.species),
                              Text(c.location.name),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
      ],
    );
  }
}
