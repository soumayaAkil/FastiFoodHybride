
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Produits extends StatefulWidget {
  @override
  ProduitsState createState() => ProduitsState();

}



  class ProduitsState extends State<Produits> {
Future getListProduits() async{
  var response = await http.get(Uri.parse('http://localhost:5001/Produits/GetProdsByIdCat/1'));
  var jsonData = jsonDecode(response.body);
  List <Produit> produits = [];
  for(var p in jsonData){
    Produit produit = Produit (p["nom_produit"],p["prix_prod"],p["image_produit"]);
    produits.add(produit);
  }
  print(produits.length);
  return produits;
}

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
  backgroundColor: Colors.white,
  elevation: 0.0,
  centerTitle: false,
  leading: IconButton(
  icon:Icon(Icons.arrow_back,color: Color(0xFF545D68)),
  onPressed: (){},
  ),
  title: Text('Produits',
  style: TextStyle(
  fontFamily: 'Varela',fontSize: 20.0,color: Color(0xFF545D68))
  ),
  actions: <Widget>[

  ],

  ),
  body:

    ListView(
    children: <Widget>[
      SizedBox(height: 15.0),
    Container(
        padding: EdgeInsets.only(right: 15.0),
        width: MediaQuery.of(context).size.width - 30.0,
        height: MediaQuery.of(context).size.height - 50.0,
        child: GridView.count(

          crossAxisCount: 2,
          primary: false,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 15.0,
          childAspectRatio: 0.8,
          children: <Widget>[

            _buildCard('Makloub', '\7DT', 'assets/cookiemint.jpg',
                false, false, context),
            _buildCard('Cookie cream', '\$5.99', 'assets/cookiecream.jpg',
                true, false, context),
            _buildCard('Cookie classic', '\$1.99',
                'assets/cookieclassic.jpg', false, true, context),
            _buildCard('Cookie choco', '\$2.99', 'assets/cookiechoco.jpg',
                false, false, context),
            _buildCard('Makloub', '\7DT', 'assets/cookiemint.jpg',
                false, false, context),
            _buildCard('Cookie cream', '\$5.99', 'assets/cookiecream.jpg',
                true, false, context),
            _buildCard('Cookie classic', '\$1.99',
                'assets/cookieclassic.jpg', false, true, context),
            _buildCard('Cookie choco', '\$2.99', 'assets/cookiechoco.jpg',
                false, false, context)
          ],
        )),],)





  );

  }
    Widget _buildCard(String name, String price, String imgPath, bool added,
        bool isFavorite, context) {
      return Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
          child: InkWell(
              onTap: () {
              },
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3.0,
                            blurRadius: 5.0)
                      ],
                      color: Colors.white),
                  child: Column(children: [
                    Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              isFavorite
                                  ? Icon(Icons.favorite, color: Color(0xFFEF7532))
                                  : Icon(Icons.favorite_border,
                                  color: Color(0xFFEF7532))
                            ])),
                    Hero(
                        tag: imgPath,
                        child: Container(
                            height: 75.0,
                            width: 75.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(imgPath),
                                    fit: BoxFit.contain)))),
                    SizedBox(height: 7.0),
                    Text(price,
                        style: TextStyle(
                            color: Color(0xFFCC8053),
                            fontFamily: 'Varela',
                            fontSize: 14.0)),
                    Text(name,
                        style: TextStyle(
                            color: Color(0xFF575E67),
                            fontFamily: 'Varela',
                            fontSize: 14.0)),
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
                    Padding(
                        padding: EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (!added) ...[
                                Icon(Icons.shopping_basket,

                                    color: Color(0xFFD17E50), size: 12.0),
                                Text('Add to cart',
                                    style: TextStyle(
                                        fontFamily: 'Varela',
                                        color: Color(0xFFD17E50),
                                        fontSize: 12.0))
                              ],
                              if (added) ...[
                                Icon(Icons.remove_circle_outline,
                                    color: Color(0xFFD17E50), size: 12.0),
                                Text('3',
                                    style: TextStyle(
                                        fontFamily: 'Varela',
                                        color: Color(0xFFD17E50),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0)),
                                Icon(Icons.add_circle_outline,
                                    color: Color(0xFFD17E50), size: 12.0),
                              ]
                            ]))
                  ]))));
    }

  }

class Produit {
  final String nom_produit,image_produit;
  final Float prix_prod;
  Produit(this.nom_produit,this.image_produit,this.prix_prod);
}


  
