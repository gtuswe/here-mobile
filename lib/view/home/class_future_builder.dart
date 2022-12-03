import 'package:flutter/material.dart';
import 'package:here/model/class.dart';

class ClassFutureBuilder extends StatefulWidget {
  final Future<List<Class>> classes;
  final Widget Function(List<Class> classes) listBuilder;

  const ClassFutureBuilder(
      {Key? key, required this.classes, required this.listBuilder})
      : super(key: key);

  @override
  _ClassFutureBuilderState createState() => _ClassFutureBuilderState();
}

class _ClassFutureBuilderState extends State<ClassFutureBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Class>>(
      future: widget.classes,
      builder: (context, snapshot) {
        // Wait list data
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        // Log errors
        if (snapshot.hasError) {
          debugPrint("Can't get class list: ${snapshot.error}");
        }
        // Check list data
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // TODO: create not found screen
          return const Text("No class found.");
        }

        // Build list
        final List<Class> classes = snapshot.data!;
        return widget.listBuilder(classes);
      },
    );
  }
}
