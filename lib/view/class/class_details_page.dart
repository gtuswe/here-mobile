import 'package:flutter/material.dart';
import 'package:here/model/class.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';
import 'package:timelines/timelines.dart';

class ClassDetailsPage extends StatefulWidget {
  final Class classInstance;
  // final User user;
  const ClassDetailsPage({Key? key, required this.classInstance}) : super(key: key);

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
          title: Center(child: Text(widget.classInstance.name ?? '')),
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
                    _attendance(widget.classInstance.attendances ?? []),
                    _participants(),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Timeline _attendance(List<bool> attendances) {
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
          return Padding(
            padding: const EdgeInsets.all(35),
            child: Text("Week ${attendances.length - index}"),
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
                    widget.classInstance.name ?? '',
                    style: context.textTheme.headline6,
                  ),
                ),
                subtitle: Text(
                  '${DateFormat('EEEE').format(widget.classInstance.upcomingDate!)} - ${widget.classInstance.upcomingDate?.hour}:${widget.classInstance.upcomingDate?.minute}',
                ),
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
      itemCount: widget.classInstance.participants?.length ?? 0,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.zero,
          child: ListTile(
            title: Text(widget.classInstance.participants?[index].name ?? ""),
            subtitle: Text(widget.classInstance.participants?[index].email ?? ""),
            leading: const ClipOval(
              child: Icon(Icons.person), // backendden image yoksa ismi baş harfi olan
            ),
          ),
        );
      },
    );
  }
}
