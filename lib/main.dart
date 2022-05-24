

import 'package:fasti_food/Commande/Commande.dart';
import 'package:fasti_food/produit/PanierProvider.dart';
import 'package:fasti_food/produit/showAllProduit.dart';
import 'package:fasti_food/Screen.dart';
import 'package:flutter/material.dart';
import 'package:fasti_food/restaurant/showAllRestau.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('userNom');
  runApp(
    MultiProvider(
        providers: [
          // create: (context) => PanierProvider(),
          ChangeNotifierProvider(create: (context) => PanierProvider()),

        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: email == null ? Screen() : Screen())),
  );
}


class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

      ),
    //  home:DetailMenu(),



      home: Page1(),

    );
  }
}

class Page1 extends StatelessWidget {
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:Text('List categories'), backgroundColor: Colors.orange,),
      body:Column(
          children: [

      Center(child: RaisedButton(
        onPressed: (){
          Navigator.of(context)
              .push(
            MaterialPageRoute(builder: (context) => MyHomePage())
          );

        },
        child: Text('Voir List des produits'),
      )
      ),

            Center(child: RaisedButton(
              onPressed: (){
                Navigator.of(context)
                    .push(
                    MaterialPageRoute(builder: (context) => DisplayRestau())
                );

              },
              child: Text('Voir List restau'),
            )
            ),

  ],),

      );


  }

}
