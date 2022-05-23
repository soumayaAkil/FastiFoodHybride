

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
            MaterialPageRoute(builder: (context) => DisplayProduit())
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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Categories"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
