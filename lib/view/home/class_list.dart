import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:here/model/class.dart';
import 'package:here/service/class.dart';
import 'package:here/view/home/class_future_builder.dart';
import 'package:here/view/class/class_details_page.dart';

class ClassList extends StatefulWidget {
  const ClassList({Key? key}) : super(key: key);

  @override
  _ClassListState createState() => _ClassListState();
}

class _ClassListState extends State<ClassList> {
  late Future<List<Class>> classes;

  @override
  void initState() {
    classes = ClassService().getAllClasses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClassFutureBuilder(
      classes: classes,
      listBuilder: _buildClassList,
    );
  }

  Widget _buildClassList(List<Class> classes) {
    return ListView.builder(
        itemCount: classes.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final Class classInstance = classes[index];

          return _classCard(classInstance);
        });
  }

  Widget _classCard(Class classInstance) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const ClassDetailsPage(/*classInstance: classInstance*/)),
      ),
      child: Card(
        child: Column(
          children: [
            classInstance.image != null
                ? CachedNetworkImage(
                    imageUrl: classInstance.image!,
                    height: 210,
                    fit: BoxFit.fill)
                : const Placeholder(),
            Text(classInstance.name ?? ""),
            Text(classInstance.destination ?? ""),
          ],
        ),
      ),
    );
  }
}
