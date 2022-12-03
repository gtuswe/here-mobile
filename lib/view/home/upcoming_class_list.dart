import 'package:flutter/material.dart';
import 'package:here/model/class.dart';
import 'package:here/service/class.dart';
import 'package:here/view/home/class_future_builder.dart';
import 'package:here/view/class/class_details_page.dart';

class UpcomingClassList extends StatefulWidget {
  const UpcomingClassList({Key? key}) : super(key: key);

  @override
  _UpcomingClassListState createState() => _UpcomingClassListState();
}

class _UpcomingClassListState extends State<UpcomingClassList>
    with AutomaticKeepAliveClientMixin<UpcomingClassList> {
  late Future<List<Class>> upcomingClasses;

  @override
  void initState() {
    upcomingClasses = ClassService().getUpcomingClasses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ClassFutureBuilder(
      classes: upcomingClasses,
      listBuilder: _buildUpcomingClassList,
    );
  }

  Widget _buildUpcomingClassList(List<Class> classes) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final Class classInstance = classes[index];

          return _classCard(classInstance);
        });
  }

  Widget _classCard(Class classInstance) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ClassDetailsPage()),
      ),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(classInstance.name ?? ""),
            Text(classInstance.upcomingDate?.weekday.toString() ?? ""),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
