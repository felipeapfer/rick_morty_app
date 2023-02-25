import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/pages/character_details_page.dart';
import 'package:rick_morty_app/repositories/characteres_repository.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  late CharacterRepository cr;

  @override
  Widget build(BuildContext context) {
    cr = context.watch<CharacterRepository>();
    return Scaffold(
      backgroundColor: const Color(0xFFE7E7E7),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF3D3D3D),
        title: const Text(
          'Characters',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
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
              height: 3,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  cr.isLoading
                      ? const CircularProgressIndicator()
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int character) {
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CharacterDetails(
                                        c: cr.characteres[character]),
                                  ),
                                );
                              },
                              leading: SizedBox(
                                width: 40,
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: Text(
                                    cr.characteres[character].id.toString(),
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
                                    cr.characteres[character].name.toString(),
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
                          itemCount: cr.characteres.length,
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
