import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rick_morty_app/models/character.dart';

import 'package:http/http.dart' as http;

class CharacterRepository extends ChangeNotifier {
  bool isLoading = true;
  List<Character> _characteres = [];

  List<Character> get characteres => _characteres;

  CharacterRepository() {
    getAllCharacteres();
  }

  Future getAllCharacteres() async {
    String uri = "https://rickandmortyapi.com/api/character";
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
