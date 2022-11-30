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
    SizeConfig().init(context);
    return Center(
      child: ListView(
        children: [
          SizedBox(
            height: SizeConfig.blockSizeVertical * 20,
            child: const UpcomingClassList(),
          ),
          const ClassList(),
        ],
      ),
    );
  }
}
