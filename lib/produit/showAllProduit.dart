import 'dart:convert';


import 'package:fasti_food/Models/produit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fasti_food/Models/restau.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../Models/ModelPanierProd.dart';
import 'Panier.dart';
import 'PanierProvider.dart';




class DisplayProduit extends StatefulWidget
{
  final int id_restau;
  const DisplayProduit({Key key,@required this.id_restau}) : super(key: key);




  @override
  _DisplayProduitState createState() => _DisplayProduitState();

}
class _DisplayProduitState extends State<DisplayProduit>
{
  int ID,NBMin=1;
  List<produit> produitList =[];


  Future<List<produit>> getAll() async
  {


    produitList.clear();
    var response = await http.get("http://10.0.2.2:5001/Produits/GetProdsByIdRestaus/${widget.id_restau}");



    if(response.statusCode == 200)
    {
      produitList.clear();
    }
    var decodedData = jsonDecode(response.body);
    for (var u in decodedData)
    {

      produitList.add(produit(u['id_prod'],u['nomProd'],u['imageProd'],u['id_restau'],u['prix_prod'],u['unite']));

    }

    debugPrint('tableau produit : $produitList');
    //debugPrint('decodedd : $decodedData');
  //  restau2.add(Restau(1,'restau1','https://tekmanda.imgix.net/restaurants%2F79235064-3aeb-41f5-970a-23127e3a8779.jpg'));
  //  restau2.add(Restau(2,'restau2','https://tb-static.uber.com/prod/image-proc/processed_images/fa54d1287c472c5968836309fb4497b4/c73ecc27d2a9eaa735b1ee95304ba588.jpeg'));
    return produitList;
  }
  Future<void> _showMyDialog(produit prod) async {
    print(prod.nomProd);
    print(";;");
    return showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          int count = NBMin, som;

           som = count * prod.prix_prod;
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Center(
                    child: Text("prix unitaire : "+
                      prod.prix_prod.toString()+" DT",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network("http://10.0.2.2:5001/images/${prod.imageProd}",
                          fit: BoxFit.cover,
                          width: 250,
                          height: 200,
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: RaisedButton(
                              color: Colors.orange,
                              onPressed: () {
                                setState(() {
                                  if (count > NBMin) {
                                    count--;
                                    som = count * prod.prix_prod;
                                  }
                                });
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
                            '$count',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            child: RaisedButton(
                              color: Colors.orange,
                              onPressed: () {
                                setState(() {
                                  count++;
                                  som = count * prod.prix_prod;
                                });
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
                      Row(

                        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.asset('assets/argon.jpg',
                                      width: 75, height: 75),
                                ),
                              ),
                            ),
                            Text(
                              ':  ${som} dt',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Annuler',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.orange,
                        )),
                    onPressed: () {
                      setState(() {
                      //  nomProduit = prod.nomProd;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  Container(
                    child: SizedBox(
              width: 140, // <-- Your width
              height: 30,
              child:RaisedButton(
                      color: Colors.orange,
                      onPressed:  () async {

                        PanierProduit panierSelect = PanierProduit(
                            selectedProduit: prod, qte: count, somme: som);
                        context.read<PanierProvider>().addProduit(panierSelect);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Panier(id_restau:this.widget.id_restau)),
                          //Navigator.of(context).pop();
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child:   TextButton(
              child: Text('Ajout Panier',
              style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              )),

                    ),
                  ),),
                  ),
              /*
                  TextButton(
                    child: Text('Ajout Panier',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                        )),
                    onPressed: () async {

                      setState(() {
                      //  nomProduit = prod.nomProd;
                      });
                      PanierProduit panierSelect = PanierProduit(
                          selectedProduit: prod, qte: count, somme: som);
                      context.read<PanierProvider>().addProduit(panierSelect);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Panier()),
                        //Navigator.of(context).pop();
                      );

                    },
                  ),*/
                ],
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    getAll();

    return Scaffold(

        appBar: AppBar(
          title: Text('List des des produits'),
          elevation: 0.0,
          backgroundColor: Color(0xFFEEA734),
        ),

        body: FutureBuilder(
            future: getAll(),

            builder: (context, AsyncSnapshot<List<produit>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              resizeToAvoidBottomInset: false;
              return GridView.builder(

                  itemCount: snapshot.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16
                  ), itemBuilder: (context, index)=>
                  InkWell(
                    child:Card(

                    child : Column(
                      children: [
                        Image.network("http://10.0.2.2:5001/images/${snapshot.data[index].imageProd}",width: 120,height: 120),
                        SizedBox(height:10),
                        Title(color: Colors.black, child: Text(snapshot.data[index].nomProd,style: TextStyle(fontWeight: FontWeight. bold,fontSize: 15)))
                      ],
                    ),

                  ),


                onTap:()async {
                  ID = snapshot.data[index].id_prod;
                  print(ID);

                  await _showMyDialog(snapshot.data[index]);
                },

              ),

              );
            }
        ));

  }



}
