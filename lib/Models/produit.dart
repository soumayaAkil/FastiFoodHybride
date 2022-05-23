
class produit {
  int id_prod;
  String nomProd;
  String imageProd;
  int id_restau;
  int prix_prod;
  String unite;

  produit(this.id_prod,this.nomProd, this.imageProd, this.id_restau,this.prix_prod,this.unite);

  produit.formJson(Map<String, dynamic> json) {
    id_prod = json['id_prod'];
    nomProd = json['nomProd'];
    imageProd = json['imageProd'];
  //  print(json['prix_prod'].runtimeType);

    id_restau = json['id_restau'];
    prix_prod = json['prix_prod'].toDouble();
    unite= json['unite'];
  }

  Map<String, dynamic> toJson(produit pr) => {
    'id_prod': pr.id_prod,
    'nomProd': pr.nomProd,
    'imageProd': pr.imageProd,
   // 'prix_prod': pr.prix_prod,
    'id_restau': pr.id_restau,
  'prix_prod' : pr.prix_prod ,
  'unite' : pr.unite,

  };
}