import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/date_service.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  late DateService dp;
  late int _selectedIndex;
  //final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    dp = context.watch<DateService>();
    _selectedIndex = dp.dateIndex;

    return SizedBox(
      height: 40,
      child: ListView.builder(
        key: const PageStorageKey<String>('DateSelection'),
        shrinkWrap: true,
        // controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: dp.futureDays,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                dp.setDate(index);
              });
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: index == _selectedIndex ? Colors.orange : Colors.white,
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dp.weekdayStr[index],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:
                          index == _selectedIndex ? Colors.white : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dp.datesStr[index],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                          index == _selectedIndex ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
