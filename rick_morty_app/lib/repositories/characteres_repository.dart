import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rick_morty_app/models/character.dart';

import 'package:http/http.dart' as http;

class CharacterRepository extends ChangeNotifier {
  bool isLoading = true;
  List<Character> _characteres = [];
  Map<int, Character> _episode_ref = {};

  String uri = "https://rickandmortyapi.com/api/character";

  List<Character> get characteres => _characteres;

  CharacterRepository() {
    getAllCharacteres();
  }

  getCharById(id) async {
    if (_episode_ref.containsKey(id)) {
      print("Cache Map");
      return _episode_ref[id];
    } else {
      print("Request API");
      var url = "$uri/${id.toString()}";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        _episode_ref[id] = Character.fromJson(json);
        return _episode_ref[id];
      } else {
        return null;
      }
    }

    /* var url = "$uri/${id.toString()}";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print(response);
      final json = jsonDecode(response.body);
      //_episode_ref[id] = Character.fromJson(json);
      return Character.fromJson(json);
    } else {
      throw Exception("Erro no Json");
    } */
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
