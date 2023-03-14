import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/models/episode.dart';
import 'package:rick_morty_app/pages/episode_details_page.dart';
import 'package:rick_morty_app/repositories/episodes_repository.dart';
import 'package:rick_morty_app/repositories/user_repository.dart';
import 'package:rick_morty_app/widgets/date_selection.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late List<Episode> temp;
  late EpisodeRepository es;
  late UserRepository userR;
  @override
  Widget build(BuildContext context) {
    debugPrint(context.watch<UserRepository>().user.pictureUrl);

    es = context.watch<EpisodeRepository>();
    userR = context.watch<UserRepository>();
    //print(dotenv.env['AWS_REGION']);
    return MaterialApp(
      title: 'Rick and Morty ',
      //title: dotenv.env['AWS_REGION']!,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
          drawer: Drawer(
            backgroundColor: Colors.deepOrangeAccent[500],
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  currentAccountPicture: Image.network(
                      'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=robohash&f=y'),
                  accountName: Text(userR.user.name),
                  accountEmail: Text(userR.user.email),
                ),
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Editar'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String newName =
                            context.watch<UserRepository>().user.name;
                        return AlertDialog(
                          title: const Text('Editar nome'),
                          content: TextFormField(
                            initialValue: newName,
                            onChanged: (value) {
                              newName = value;
                            },
                          ),
                          actions: [
                            TextButton(
                              child: const Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              child: const Text('Salvar'),
                              onPressed: () {
                                userR.updateUserName(newName);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Sair'),
                  onTap: () {
                    userR.signOut();
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            //title: const Text('Home Page'),
            title: Text(context.watch<UserRepository>().user.name),
          ),
          body: SingleChildScrollView(
            child: Center(
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
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
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
                ])),
          )),
    );
  }
}
