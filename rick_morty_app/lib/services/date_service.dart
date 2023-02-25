import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../repositories/episodes_repository.dart';

class DateService extends ChangeNotifier {
  List<String> _dates = [];
  List<String> _weekdays = [];
  int _dateIndex = 0;
  final int _futureDays = 10;

  int get dateIndex => _dateIndex;
  List<String> get datesStr => _dates;
  List<String> get weekdayStr => _weekdays;
  int get futureDays => _futureDays;

  EpisodeRepository er;

  DateService({required this.er}) {
    _initService();
  }

  _initService() {
    _populateListDate();
  }

  _populateListDate() {
    DateTime selectedDate = DateTime.now();
    _weekdays = [];
    _dates = [];
    for (var i = 0; i < _futureDays; i++) {
      DateTime auxDate = selectedDate.add(Duration(days: i));
      _weekdays.add(
        DateFormat('E').format(auxDate),
      );
      _dates.add(
        DateFormat('d MMM').format(auxDate),
      );
    }
    notifyListeners();
  }

  setDate(index) async {
    _dateIndex = index;
    notifyListeners();
    er.getEpisodesbyDay(index);
  }
}
