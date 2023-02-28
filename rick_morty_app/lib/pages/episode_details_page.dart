import 'package:flutter/material.dart';
import 'package:rick_morty_app/models/episode.dart';

class EpisodeDetails extends StatefulWidget {
  final Episode ep;
  const EpisodeDetails({super.key, required this.ep});

  @override
  State<EpisodeDetails> createState() => _EpisodeDetailsState();
}

class _EpisodeDetailsState extends State<EpisodeDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.ep.episode),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
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
                //indicator: BoxDecoration(
                //    color: Colors.orange[300],
                //    borderRadius: BorderRadius.circular(25.0)),
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
                    text: 'Tab 1',
                  ),
                  Tab(
                    text: 'Tab 2',
                  ),
                  Tab(
                    text: 'Tab 3',
                  ),
                  Tab(
                    text: 'Tab 4',
                  )
                ],
              ),
              const Expanded(
                  child: TabBarView(
                children: [
                  Center(
                    child: Text("Tab1 Pages"),
                  ),
                  Center(
                    child: Text("Tab2 Pages"),
                  ),
                  Center(
                    child: Text('Tab3 Page'),
                  ),
                  Center(
                    child: Text('Tab4 Page'),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
