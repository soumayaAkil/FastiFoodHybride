
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fasti_food/Colors.dart';
import 'package:fasti_food/Models/produit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailMenu extends StatefulWidget {
  @override
  _DetailMenuState createState() => _DetailMenuState();
}

class _DetailMenuState extends State<DetailMenu> {


  List data = List();
  Future myFuture;


  Future<List<produit>> getData() async {
    var url = 'http://10.0.2.2:5001/Produits/GetProdsByIdProd/1';
    var response = await http.get(url);
    var items = json.decode(response.body);
print(items);
    List<produit> lists = items.map<produit>((json) {

      print(json);

      return produit.formJson(json);
    }).toList();
    print(lists);
    setState(() {
      data = items;
    });
    print(lists);
    return lists;
  }


  @override
  void initState() {
    super.initState();
    getData();

  }
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
                                child:Image.network( "http://10.0.2.2:5001/images/${data[0]['image_produit']}",
                                //Image.asset('assets/coca.png',
                                  width: 200, height: 200),
                                //Image.asset('images/salha.png',width: 200,height: 200,),
                              ),


                          ),
                          Row(

                            //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SizedBox(width:100,height: 50,),
                                Text(

                                      '${ data[0]['nom_produit']}',
                                  // ':  ${som} dt',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: orange,
                                  ),
                                ),
                                SizedBox(width:100),
                                Text(

                                     '${ data[0]['unite_produit']}',
                                 // ':  ${som} dt',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: orange,
                                  ),
                                ),
                              ]),


                          Row(

                            //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SizedBox(height:120,width: 100,),
                                InkWell(
                                  child: Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child:
                                      Image.asset('assets/argon.jpg',

                                          width: 75, height: 75),
                                    ),
                                  ),
                                ),
                                Text(

                                  //'17 DT',
                                   ':${ data[0]['prix_produit']} dt',
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