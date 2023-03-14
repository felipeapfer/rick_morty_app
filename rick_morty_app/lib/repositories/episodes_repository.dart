import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/episode.dart';
import 'package:http/http.dart' as http;

class EpisodeRepository extends ChangeNotifier {
  bool isLoading = true;
  List<Episode> _episodes = [];
  String uri = "https://rickandmortyapi.com/api/episode/";

  List<Episode> get episodes => _episodes;

  EpisodeRepository() {
    getEpisodesbyDay(0);
  }

  Future getEpisodesbyDay(dateIndex) async {
    isLoading = true;
    var localUrl = uri;
    notifyListeners();
    for (var j = (dateIndex) * 7; j < (dateIndex + 1) * 7; j++) {
      localUrl += "${j.toString()},";
    }
    localUrl = localUrl.substring(0, localUrl.length - 1);

    try {
      final response = await http.get(Uri.parse(localUrl));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        _episodes = [];
        for (var element in json) {
          List<String> p = [];
          for (var personagem in element['characters']) {
            p.add(personagem);
          }
          _episodes.add(Episode(
            id: element['id'],
            name: element['name'],
            airDate: element['air_date'],
            episode: element['episode'],
            created: element['created'],
            url: element['url'],
            characters: p,
          ));
        }
      } else {
        return [];
      }
    } catch (e) {
      //print(e);
    }
    isLoading = false;
    notifyListeners();
  }
}
