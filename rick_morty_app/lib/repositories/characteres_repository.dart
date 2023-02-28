import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rick_morty_app/models/character.dart';

import 'package:http/http.dart' as http;

class CharacterRepository extends ChangeNotifier {
  bool isLoading = true;
  List<Character> _characteres = [];
  Map<int, dynamic> _episode_ref = {};

  String uri = "https://rickandmortyapi.com/api/character";

  List<Character> get characteres => _characteres;

  CharacterRepository() {
    getAllCharacteres();
  }

  getEpisodeById(id) async {
    if (_episode_ref.containsKey(id)) {
      print("Cache Map");
      return _episode_ref[id];
    } else {
      print("Request API");
      final response = await http.get(Uri.parse("$uri/${id.toString()}"));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (!json['error']) {
          _episode_ref[id] = {
            'name': json['name'],
            'image': json['image'],
            'status': json['status'],
            'location': json['location'],
          };
          return _episode_ref[id];
        }
        return {};
      }
    }
  }

  Future getAllCharacteres() async {
    isLoading = true;
    notifyListeners();
    try {
      var response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        _characteres = [];
        while (json['info']['next'] != null) {
          for (var element in json['results']) {
            _characteres.add(Character.fromJson(element));
          }
          response = await http.get(Uri.parse(json['info']['next']));
          if (response.statusCode == 200) {
            json = jsonDecode(response.body);
          } else {
            break;
          }
        }
        for (var element in json['results']) {
          _characteres.add(Character.fromJson(element));
        }
      }
    } catch (e) {
      //print(e);
    }
    isLoading = false;
    notifyListeners();
  }
}
