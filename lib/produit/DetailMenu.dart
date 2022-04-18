
import 'package:fasti_food/Colors.dart';
import 'package:flutter/material.dart';

class DetailMenu extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<DetailMenu> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("FastiFood"),
        backgroundColor: orange,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(


                    padding: const EdgeInsets.all(10),

                    child: Material(
                      child:Column(
                        children: [
                          InkWell(
                            onTap: () {},

                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.30),
                                child: Image.asset('images/coca.png',
                                  width: 200, height: 200),
                                //Image.asset('images/salha.png',width: 200,height: 200,),
                              ),


                          ),
                          Row(

                            //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SizedBox(width:100),
                                Text(

                                      'coca',
                                  // ':  ${som} dt',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: orange,
                                  ),
                                ),
                                SizedBox(width:100),
                                Text(

                                     '1.5 l',
                                 // ':  ${som} dt',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: orange,
                                  ),
                                ),
                              ]),
                          SizedBox(height:100,width: 100,),

                          Row(

                            //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                InkWell(
                                  child: Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.asset('images/argon.jpg',
                                          width: 75, height: 75),
                                    ),
                                  ),
                                ),
                                Text(

                                  '17 DT',
                                  // ':  ${som} dt',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: orange,
                                  ),
                                ),
                              ]),

                          SizedBox(height:120),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: orange,

                                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                               ),
                            onPressed: (){},
                             child:TextButton(

                               child:Text(
                               ' Ajouter au panier',
                               style: TextStyle(
                                 fontSize: 23,
                                 fontWeight: FontWeight.bold,
                                 color: Colors.black,
                               ),
                             ),

                ),
                          //color: Colors.grey[200],

                         ),


],
    ),
    ),
    ),
    );

  }

}