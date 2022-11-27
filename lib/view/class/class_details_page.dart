import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:timelines/timelines.dart';

class ClassDetailsPage extends StatefulWidget {
  const ClassDetailsPage({Key? key}) : super(key: key);

  @override
  State<ClassDetailsPage> createState() => _ClassDetailsPageState();
}

class _ClassDetailsPageState extends State<ClassDetailsPage> {
  final Color _selectedTabColor = const Color.fromARGB(255, 103, 80, 164);
  final String _name = "Atacan Başaran";
  final String _mail = "a.basaran2020@gtu.edu.tr";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Software Engineering")),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 10), //paddingi temadan cekeriz
                child: IconButton(onPressed: (() {}), icon: const Icon(Icons.more_vert)))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 7,
              child: _classDetailsPageCard(context),
            ),
            Expanded(
              flex: 2,
              child: TabBar(
                tabs: const [
                  Tab(text: "Attendance"),
                  Tab(
                    text: "Participants",
                  ),
                ],
                labelColor: _selectedTabColor, // renk dosyası yaparız blki
                unselectedLabelColor: Colors.black,
                indicatorColor: _selectedTabColor,
              ),
            ),
            Expanded(
                flex: 12,
                child: TabBarView(
                  children: [
                    _attendance(),
                    _participants(),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Timeline _attendance() {
    return Timeline.tileBuilder(
      theme: TimelineThemeData(
        indicatorTheme: const IndicatorThemeData(
          color: Colors.green,
        ),
        connectorTheme: const ConnectorThemeData(
          color: Colors.grey,
          space: 20,
        ),
      ),
      //padding: EdgeInsets.only(top: context.height * 0.025, right: context.width * 0.7),
      builder: TimelineTileBuilder.fromStyle(
        contentsAlign: ContentsAlign.basic,
        indicatorStyle: IndicatorStyle.dot,
        contentsBuilder: ((context, index) {
          return const Padding(
            padding: EdgeInsets.all(35),
            child: Text("Wekk 6 Here!"),
          );
        }),
        itemCount: 6,
      ),
    );
  }

  Card _classDetailsPageCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 6, right: 6), // temadan çekilir
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    "Software Engineering",
                    style: context.textTheme.headline6,
                  ),
                ),
                subtitle: const Text("Monday (1.30PM-4.30PM) Z06"),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Collected Lesson"),
                    Text("6/24"),
                  ],
                ),
                subtitle: const LinearProgressIndicator(
                  value: 6 / 24, // backendden olmuş ders sayısı
                  color: Colors.green,
                  backgroundColor: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView _participants() {
    return ListView.builder(
      itemCount: 8,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.zero,
          /*shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          )),*/
          child: ListTile(
            title: Text(_name),
            subtitle: Text(_mail),
            leading: const ClipOval(
              child: Icon(Icons.person), // backendden image yoksa ismi baş harfi olan
            ),
          ),
        );
      },
    );
  }
}
