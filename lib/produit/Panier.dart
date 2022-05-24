import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/ModelPanierProd.dart';
import 'PanierProvider.dart';


class Panier extends StatefulWidget {
  @override
  _PanierState createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var somme_prix;
    return Scaffold(
      appBar: AppBar(
        title: Text('Panier'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        height: height,
        width: width,
        child:  Consumer<PanierProvider>(
          builder: (BuildContext context, value, Widget child) {

            return Stack(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.produits.length,
                  itemBuilder: (BuildContext context, int index) {
                    PanierProduit produit = value.produits[index];


                    return    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child:Container(
                      height: 80,
                      color: Colors.black26 ,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '${produit.qte}',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network("http://10.0.2.2:5001/images/${produit.selectedProduit.imageProd}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            '${produit.somme} dt',
                            //'${produit.selectedProduit.prix_P}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                child: RaisedButton(
                                  color: Colors.orange,
                                  onPressed: () {
                                    /*
                                    setState(() {
                                      if (count > NBMin) {
                                        count--;
                                        som = count * prod.prix_prod;
                                      }
                                    });
                                    */
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ),
                              ),
                              /*
                          IconButton(
                            icon: Icon(Icons.minimize),
                            onPressed: () {
                              setState(() {
                                if (count > produit.nb_min) {
                                  count--;
                                }
                              });
                            },
                          ),
                          */
                              Text(
                                //'$count',
                                '13',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                child: RaisedButton(
                                  color: Colors.orange,
                                  onPressed: () {
                                    /*
                                    setState(() {
                                      count++;
                                      som = count * prod.prix_prod;
                                    });

                                     */
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    );
                  },


                ),
                Positioned(
                  bottom: 15,
                  child: Container(
                    height: height * 0.1,
                    width: width * 0.5 ,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Container(
                        height: height * 0.2,
                        width: width * 0.5,
                        child: RaisedButton(
                          color: Colors.brown[400],
                          onPressed: () => {
                            context.read<PanierProvider>().clearProduit(),
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: new Text(
                            'Anuuler',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ), Positioned(
                  bottom: 15,
                  left: 110,
                  child: Container(
                    height: height * 0.1,
                    width: width * 0.9,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Container(
                        height: height * 0.2,
                        width: width * 0.5,
                        child: RaisedButton(
                          color: Colors.orange,
                          onPressed: () async {
                            DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
                            var date = dateFormat.format(DateTime.now());
                            SharedPreferences preff = await SharedPreferences.getInstance();
                            int id_client = preff.getInt("userId");
                            List<Map<String, dynamic>> Listproduction=[];
                            List<Map<String, dynamic>> prods= [];
                            value.produits.forEach((element) {
                              // print('${element.selectedProduit.toJson(element.selectedProduit)}');
                              //var ligne=element.selectedProduit.toJson(element.selectedProduit);
                              Ajoutprod PROD=Ajoutprod();
                              /*          var f= PROD.parseproduit(id_client,element.selectedProduit.id_prod,element.qte,element.somme,date,value.totale);
                              Listproduction.add(f);
*/
                            });
                            print(Listproduction);
                            saveProd(Listproduction);
                            // print(prods);
                            ajoutproduction(prods);
                            //getprefQ() async{
/*
                          SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                          quantite = preferences.getInt("quantite");

                          if (quantite != 0) {
                            setState(() {
                              quantite = preferences.getInt("quantite");
                              isSelectIn = true;
                            });
                          }
                          */
                            /*
                          DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
                          var x = dateFormat.format(DateTime.now());

                          print(produit.id);

                          print(quantite);
                          SharedPreferences preff = await SharedPreferences.getInstance();
                          int id_femme = preferences.getInt("userId");
                          print(id_femme);
                          saveProd(x, quantite, widget.id_produit, id_femme);
                          */
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child:Text(
                            '${value.totale == 0 ? '' : value.totale } Valider',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),

                          ),
                        ),
                      ),
                    ),
                  ),
                ),


              ],
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> saveProd(var a) async {
    setState(() {
      var visble = true;
    });

    var url = 'http://10.0.2.2:3000/prod/liste';
    var response = await http.post(
      url,
      body: json.encode(a),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    var message = jsonDecode(response.body);
  }

  Future<dynamic> ajoutproduction(List<Map<String, dynamic>> prods) async {

    var url = 'http://10.0.2.2:3000/production/post';

    var response = await http.post(
      url,
      body: json.encode(prods),
      headers: {
        'Content-Type': 'application/json',
      },
    );
  }
}

class Ajoutprod{
  int id_femme;
  int id_produit;
  int quantite;
  int somme;
  String date_transaction;

  int somme_prix;





  Ajoutprod({this.id_femme, this.id_produit ,this.quantite ,this.somme, this.date_transaction, this.somme_prix});
  Map<String, dynamic> parseproduit(int id_femme, int id_P,int qte,double somme,String date,double somme_prix) =>
      {
        "date_transaction":date,
        "quantite":qte,
        "id_produit":id_P,
        "somme":somme,
        "somme_prix":somme_prix,
        "id":id_femme
      };

}