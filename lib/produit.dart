import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class ProduitScreen extends StatefulWidget {

  ProduitScreen ({Key key}) : super(key: key);
  _ProduitScreenState createState() => _ProduitScreenState();
}
class _ProduitScreenState extends State<ProduitScreen > {
  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    getData();
    super.initState();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels== _scrollController.position.maxScrollExtent){
        bodyHome();
      }
    });
  }
  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }
  Future<List> getData() async {
    var myurl = "http://10.0.2.2:5001/Produits/GetProdsByIdCat/1";
    var response = await http.get(Uri.parse(myurl));
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }
  static const kDefaultShadow = BoxShadow(
    offset: Offset(0, 15),
    blurRadius: 27,
    color: Colors.black12, // Black color with 12% opacity
  );

  headd() {
    return AppBar(
      title: Text(
        "Produits",
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Signatra",
          fontSize: 50.0,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      centerTitle: true,
      backgroundColor: Color(0xff00c4cc),
    );

  }

  bodyHome(){
  return FutureBuilder(
  future: getData(),
  builder: (BuildContext context, AsyncSnapshot snapshot) {
  if (snapshot.hasData) {
  return ListView.builder(

  shrinkWrap: true,
  itemCount: snapshot.data.length,
  physics: const AlwaysScrollableScrollPhysics(), // new
  controller: _scrollController,
  itemBuilder: (context, index) {
  Size size = MediaQuery.of(context).size;
    return Container(
    margin: EdgeInsets.symmetric(
    horizontal: 20.0,
    vertical: 20.0 / 2,
    ),
    // color: Colors.blueAccent,

    height: 160,
    child: InkWell(
    onTap: () {
   
    },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          // Those are our background
          Container(
            height: 136,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: index.isEven
                  ? Color(0xff00c4cc)
                  : Color(0xFFFFA41B),
              boxShadow: [kDefaultShadow],
            ),
            child: Container(
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
            ),
          ),
          // our product image
          Positioned(
            top: 0,
            right: 0,
            child: Hero(
              tag: snapshot.data[index]['id_produit'],
              child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 20.0),
                  height: 160,
                  // image is square but we add extra 20 + 20 padding thats why width is 200
                  width: 200,
                  child:Image.network(
                      "http://10.0.2.2:5001/images/${snapshot.data[index]['image_produit']}"),
              ),
            ),
          ),
          // Product title and price
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: 136,
              // our image take 200 width, thats why we set out total width - 200
              width: size.width - 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0),
                    child: Text(
                      snapshot.data[index]['nom_produit'],
                      style:
                      Theme.of(context).textTheme.button,
                    ),
                  ),
                  // it use the available space
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0 * 1.5,
                      // 30 padding
                      vertical: 20.0 / 4, // 5 top and bottom
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff00c4cc),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(22),
                        topRight: Radius.circular(22),
                      ),
                    ),
                    child: Text(
                      snapshot.data[index]['prix_prod'].toString()+" TND",
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    ); /////
  });
  }
  return CircularProgressIndicator();

//                      ],
//                    ),
//                  ),
//                ],
//              ),
//            );
  });

  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            appBar: headd(),
            backgroundColor: Color(0x8000c4cc),
            body:bodyHome()
        ));
  }
}


