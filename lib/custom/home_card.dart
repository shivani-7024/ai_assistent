import 'package:ai_assistent/model/home_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

import '../Helper/global.dart';
class HomeCard extends StatelessWidget {
  final HomeType hometype;

  const HomeCard({super.key, required this.hometype});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: hometype.onTap,
      child: Card(
        color: Colors.blue.withOpacity(.2),
        elevation: 0,
        margin: EdgeInsets.only(bottom: mq.height*.02),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(const Radius.circular(20))
        ),
        child: hometype.leftAlign? Row(
          children: [
            Spacer(),
            Lottie.asset("assets/lottie/${hometype.lottie}", width: mq.width*.35),
            Spacer(),
            Text(hometype.title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black),),
            Spacer(flex: 2)
          ],
        )
        :
          Row(
          children: [
      Spacer(flex: 2),
      Text(hometype.title,
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black),
      ),
            Spacer(),
            Lottie.asset("assets/lottie/${hometype.lottie}", width: mq.width*.35),
            Spacer()
      ],
      ),
      ).animate().fade(duration: 1.seconds),
    );
  }
}
