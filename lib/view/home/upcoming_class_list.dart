import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:here/model/class.dart';
import 'package:here/service/class.dart';
import 'package:here/utils/size_config.dart';
import 'package:here/view/home/class_future_builder.dart';
import 'package:here/view/class/class_details_page.dart';
import 'package:intl/intl.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: SizeConfig.screenHeight / 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(width: 140, height: 80,
                    imageUrl: classInstance.image ?? '',
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.broken_image),
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  '${DateFormat('EEEE').format(classInstance.upcomingDate!)} - ${classInstance.upcomingDate?.hour}:${classInstance.upcomingDate?.minute}',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text(
                  '${classInstance.name}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  '${classInstance.courseCode} • ${classInstance.destination}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
