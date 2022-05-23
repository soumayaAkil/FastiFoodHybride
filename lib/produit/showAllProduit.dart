import 'dart:convert';


import 'package:fasti_food/Models/produit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fasti_food/Models/restau.dart';
import 'package:flutter/foundation.dart';




class DisplayProduit extends StatefulWidget
{
  final int id_restau;
  const DisplayProduit({Key key,@required this.id_restau}) : super(key: key);




  @override
  _DisplayProduitState createState() => _DisplayProduitState();

}
class _DisplayProduitState extends State<DisplayProduit>
{
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
                  Card(

                    child : Column(


                      children: [

                        Image.network("http://10.0.2.2:5001/images/${snapshot.data[index].imageProd}",width: 150,height: 150),
                        SizedBox(height:10),
                        Title(color: Colors.black, child: Text(snapshot.data[index].nomProd,style: TextStyle(fontWeight: FontWeight. bold,fontSize: 15)))
                      ],

                    ),

                  )
              );


            }
        ));

  }



}
