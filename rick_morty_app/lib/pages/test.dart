import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/models/episode.dart';
import 'package:rick_morty_app/pages/episode_details_page.dart';
import 'package:rick_morty_app/repositories/episodes_repository.dart';
import 'package:rick_morty_app/widgets/date_selection.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late List<Episode> temp;
  late EpisodeRepository es;
  @override
  Widget build(BuildContext context) {
    es = context.watch<EpisodeRepository>();
    return MaterialApp(
      title: 'Rick and Morty ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Home Page'),
          ),
          body: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                const SizedBox(
                  height: 100,
                  child: DateSelector(),
                ),
                es.isLoading
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
                                  es.episodes[episode].id.toString(),
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
                                  es.episodes[episode].name,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EpisodeDetails(
                                        ep: es.episodes[episode])),
                              );
                            },
                          );
                        },
                        separatorBuilder: (_, ___) => const Divider(),
                        itemCount: es.episodes.length,
                      ),
              ]))),
    );
  }
}
