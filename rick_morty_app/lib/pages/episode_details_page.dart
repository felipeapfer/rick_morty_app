import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rick_morty_app/models/episode.dart';

import 'episode_character_details.dart';

class EpisodeDetails extends StatefulWidget {
  final Episode ep;
  const EpisodeDetails({super.key, required this.ep});

  @override
  State<EpisodeDetails> createState() => _EpisodeDetailsState();
}

class _EpisodeDetailsState extends State<EpisodeDetails>
    with SingleTickerProviderStateMixin {
  //late CharacterRepository cr;
  List<String> charIds = [];
  //List<Character> chars = [];
  //List<Future<Character>> chars = [];
  //List<bool> isLoading = [true, true, true, true];

  //bool isLoading = true;

  @override
  void initState() {
    super.initState();
    /* WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    }); */
    Random r = Random();
    for (var i = 0; i < 4; i++) {
      charIds.add(widget.ep.characters[r.nextInt(widget.ep.characters.length)]
          .split("/")
          .last);
    }
  } /*

  _loadData() async {
    _loadCharacteres();
    _refreshScreen();
  }

  _refreshScreen() {
    setState(() {
      isLoading = false;
    });
  }

  _loadCharacteres() async {
    final aux = await cr.getCharById(5);
    for (var i = 0; i < 4; i++) {
      chars.add(aux);
    }
  } */

  @override
  Widget build(BuildContext context) {
    // cr = context.watch<CharacterRepository>();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.ep.episode),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    widget.ep.name,
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
                Text(widget.ep.airDate.toString()),
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
                Text(widget.ep.created.toString()),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const TabBar(
              isScrollable: true,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 3.0, color: Colors.black38),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
                insets: EdgeInsets.symmetric(horizontal: 16),
              ),
              labelStyle: TextStyle(
                color: Colors.black87,
              ),
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(
                  text: 'Character 1',
                ),
                Tab(
                  text: 'Character 2',
                ),
                Tab(
                  text: 'Character 3',
                ),
                Tab(
                  text: 'Character 4',
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  for (var element in charIds)
                    Center(
                      child: EpisodeCharacterDetails(id: int.parse(element)),
                    )
                ],
              ),
            ),
          ]),
        ),
      ),

      /*  Center(
                    child: EpisodeCharacterDetails(
                      id: 4,
                    ),
                  ) */
    );
  }
}
