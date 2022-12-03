import 'package:flutter/material.dart';
import 'package:here/utils/size_config.dart';
import 'package:here/view/home/class_list.dart';
import 'package:here/view/home/upcoming_class_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Center(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('Upcoming Classes', style: Theme.of(context).textTheme.titleMedium,),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 20,
            child: const UpcomingClassList(),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text('All Your Events', style: Theme.of(context).textTheme.titleMedium,),
          ),
          const ClassList(),
        ],
      ),
    );
  }
}
