import 'package:ai_assistent/Screens/home_screen.dart';
import 'package:ai_assistent/model/on_board.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Helper/global.dart';
class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PageController();

    final list = [Onboard(title: "Ask Me Anything",
        subtitle: "I can be your Best Friend & you can ask me anything & I will be help you",
        lottie: "ai_ask"),
    Onboard(title: "Imagination to Reality",
        subtitle: "Just imagine anything & let me know, I will create something wonderful for you",
        lottie: "ai_play")
    ];

    return Scaffold(
      body: PageView.builder(controller: c,
          itemCount: list.length,itemBuilder: (context, index){
        return Column(
          children: [
            Spacer(),
            Lottie.asset("assets/lottie/${list[index].lottie}.json"),
            Text(list[index].title, style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: .5
            ),
            ),
            SizedBox(height: mq.height* .015),
            SizedBox(width: mq.width*.6,
              child: Text(list[index].subtitle,
                textAlign:TextAlign.center,
                style: TextStyle(fontSize: 15, letterSpacing: .5),),
            ),
            Spacer(),
            Wrap(
              spacing: 10,
              children: List.generate(2, (i) => Container(
                width: i == index? 15 : 10,
                height: 8,
                decoration: BoxDecoration(
                    color: i == index? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(5))
                ),
              )),
            ),
            Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(), elevation: 0,
                    minimumSize: Size(mq.width*.4, 50),
                    backgroundColor: Colors.blue
                ),
                onPressed: () {
                  if(index == list.length-1){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
                  }
                  else{
                    c.nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
                  }
                }, child: Text(index == list.length-1 ? "Finish" : "Next",
                style:TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white)))
            ,Spacer(flex: 2,)
          ],
        );
      }),
    );
  }
}
