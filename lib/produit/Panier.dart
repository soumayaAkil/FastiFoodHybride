import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Commande/Commande.dart';
import '../Models/ModelPanierProd.dart';
import 'PanierProvider.dart';


class Panier extends StatefulWidget {
  final int id_restau;

  const Panier({Key key, @required this.id_restau}) : super(key: key);
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


                              var f= PROD.parseproduit(1,element.selectedProduit.id_prod,element.qte,widget.id_restau,value.totale);

                              Listproduction.add(f);

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MyHomePage()),
                                //Navigator.of(context).pop();
                              );
                            });
                            print(Listproduction);
                            ajoutproduction(Listproduction);


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

    var url = 'http://10.0.2.2:5001/commandes/AddCommande';
    debugPrint('tableau prods : $prods');
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
  int id_client;
  int id_prod;
  int quantite;
  int id_restau;
  double somme_com;





  Ajoutprod({this.id_client, this.id_prod ,this.quantite ,this.id_restau, this.somme_com});

  Map<String, dynamic> parseproduit(int id_client, int id_P,int qte,int id_restau,double somme_prix) =>
      {
        "quantite":qte,
        "id_produit":id_P,
        "id_restau":id_restau,
        "somme_com":somme_prix,
        "id_client":id_client
      };


}