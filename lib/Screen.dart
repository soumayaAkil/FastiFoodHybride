import 'package:fasti_food/main.dart';
import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  static String id = 'Screen';

  @override
  Widget build(BuildContext context) {


    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        },
        child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset('assets/splashscreen.PNG',
              fit: BoxFit.cover,
            ),
          ),),
      ),

    );
    /*Scaffold(
        body: Container(
            decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('images/lion.jpg'),
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ),

    )),); */
  }
}
