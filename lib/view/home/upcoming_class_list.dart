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
    super.build(context);
    SizeConfig.init(context);
    return ClassFutureBuilder(
      classes: upcomingClasses,
      listBuilder: _buildUpcomingClassList,
    );
  }

  Widget _buildUpcomingClassList(List<Class> classes) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final Class classInstance = classes[index];

          return ClassCard(classInstance: classInstance);
        });
  }

  @override
  bool get wantKeepAlive => true;
}

class ClassCard extends StatelessWidget {
  final Class classInstance;

  const ClassCard({Key? key, required this.classInstance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffoldMessenger = ScaffoldMessenger.of(context);
    classDetailsNavigator(Class classDetail) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ClassDetailsPage(classInstance: classDetail),
        ));
    return InkWell(
      onTap: () async {
        var classDetail =
            await ClassService().getClassDetailsById(classInstance.id);

        if (classDetail == null) {
          scaffoldMessenger.showSnackBar(const SnackBar(
            content: Text('Class detail not found!'),
          ));
        } else {
          classDetailsNavigator(classDetail);
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  width: SizeConfig.blockSizeVertical * 20,
                  height: SizeConfig.blockSizeVertical * 9,
                  imageUrl: '${classInstance.image}?t=${DateTime.now()}',
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
    );
  }
}
