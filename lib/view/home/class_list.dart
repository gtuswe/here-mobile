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

          return ClassTile(classInstance: classInstance, index: index);
        });
  }
}

class ClassTile extends StatelessWidget {
  final int index;
  final Class classInstance;

  const ClassTile(
      {super.key, required this.classInstance, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 9.0),
      child: Card(
        elevation: 0,
        color: const Color(0xfffffbfe),
        child: ListTile(
          onTap: () async {
            var classDetail =
                await ClassService().getClassDetailsById(classInstance.id);

            if (classDetail == null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Class detail not found!'),
              ));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ClassDetailsPage(classInstance: classDetail),
                  ));
            }
          },
          visualDensity: const VisualDensity(vertical: 4),
          leading: _leading,
          title: _title,
          subtitle: _subtitle,
          trailing: _trailing,
        ),
      ),
    );
  }

  Widget get _leading => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              (index + 1).toString().padLeft(2, '0'),
              style: TextStyle(
                  color: Colors.grey.shade700, fontWeight: FontWeight.w500),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              width: 72,
              height: 72,
              imageUrl: classInstance.image ?? '',
              errorWidget: (context, url, error) =>
                  const Icon(Icons.broken_image),
              fit: BoxFit.cover,
            ),
          ),
        ],
      );

  Widget get _title => Text(
        classInstance.name ?? '',
        softWrap: false,
      );

  Widget get _subtitle {
    List<Widget> rowItems = [];
    Widget absent = const Icon(
      Icons.cancel,
      color: Colors.redAccent,
      size: 16,
    );
    Widget attended = const Icon(
      Icons.check_circle,
      color: Colors.lightGreen,
      size: 16,
    );

    classInstance.mostRecentFiveAttendance ??= List.filled(5, false);
    for (var element in classInstance.mostRecentFiveAttendance!) {
      rowItems.add(
        element ? attended : absent,
      );
      rowItems.add(const Spacer());
    }
    rowItems.add(const Spacer(
      flex: 6,
    ));

    return Row(
      children: rowItems,
    );
  }

  Widget get _trailing => const SizedBox(
        height: double.infinity,
        child: Icon(
          Icons.keyboard_arrow_right,
        ),
      );
}
