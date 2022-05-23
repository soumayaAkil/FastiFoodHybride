import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fasti_food/Models/restau.dart';
import 'package:flutter/foundation.dart';

class DisplayRestau extends StatefulWidget
{
  const DisplayRestau({Key key}) : super(key: key);




  @override
  _DisplayRestauState createState() => _DisplayRestauState();
  
}
class _DisplayRestauState extends State<DisplayRestau>
{
  List<Restau> restau = [];
  List<Restau> restau2 = [];
   Future<List<Restau>> getAll() async
  {

    restau2.clear();
    restau.clear();
    var response = await http.get("http://10.0.2.2:5001/restaurant/GetAllRestaurants");



    if(response.statusCode == 200)
      {
        restau.clear();
      }
    var decodedData = jsonDecode(response.body);
    for (var u in decodedData)
      {

        restau.add(Restau(u['id_restau'],u['designation'],u['logo']));

      }

    debugPrint('tableau restauu : $restau');
    //debugPrint('decodedd : $decodedData');
    restau2.add(Restau(1,'restau1','https://tekmanda.imgix.net/restaurants%2F79235064-3aeb-41f5-970a-23127e3a8779.jpg'));
    restau2.add(Restau(2,'restau2','https://tb-static.uber.com/prod/image-proc/processed_images/fa54d1287c472c5968836309fb4497b4/c73ecc27d2a9eaa735b1ee95304ba588.jpeg'));
    return restau;
  }

  @override
  Widget build(BuildContext context) {
    getAll();

    return Scaffold(

        appBar: AppBar(
          title: Text('List des Restaurans'),
          elevation: 0.0,
          backgroundColor: Color(0xFFEEA734),
        ),

        body: FutureBuilder(
            future: getAll(),

            builder: (context, AsyncSnapshot<List<Restau>> snapshot) {
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

                          Image.network("http://10.0.2.2:5001/images/${snapshot.data[index].logo}",width: 150,height: 150),
                          SizedBox(height:10),
                          Title(color: Colors.black, child: Text(snapshot.data[index].designation,style: TextStyle(fontWeight: FontWeight. bold,fontSize: 15)))
                        ],

                      ),

                  )
              );


            }
        ));

  }



}
