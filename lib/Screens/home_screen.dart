import 'package:ai_assistent/Helper/global.dart';
import 'package:ai_assistent/apis/apis.dart';
import 'package:ai_assistent/custom/home_card.dart';
import 'package:ai_assistent/model/home_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../Helper/pref.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Pref.showOnboard = false;
  }
  @override
  Widget build(BuildContext context) {
    Apis.getAnswer('hello');
    return Scaffold(
      appBar: AppBar(elevation: 5,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: const Text(appName, style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 10),
            onPressed: (){},
              icon: const Icon(Icons.brightness_4_rounded),
          color: Colors.blue,)
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: mq.width*.04, vertical: mq.height*.01
        ),
        children:
          HomeType.values.map((e) => HomeCard(hometype: e)).toList()
      ),
    );
  }
}
