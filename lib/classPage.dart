import 'package:flutter/material.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({Key? key}) : super(key: key);

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Software Engineering")),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(onPressed: (() {}), icon: const Icon(Icons.more_vert)))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Card(
                child: SizedBox(
              height: 200,
              child: Container(color: Colors.red),
            )),
          ),
          Expanded(
            flex: 2,
            child: DefaultTabController(
              length: 2,
              child: TabBar(tabs: [
                Text(
                  "Attendance",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "Participants",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ]),
            ),
          ),
          const Expanded(
              flex: 12,
              child: TabBarView(
                children: [Text("123"), Text("345")],
              ))
        ],
      ),
    );
  }
}
