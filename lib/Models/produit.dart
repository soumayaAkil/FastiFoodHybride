
class produit {
  int id_produit;
  int id_categorie;
  String nom_produit;
  String image_produit;


  int id_restau;
  int prix_produit;
  String unite_produit;

  produit(this.id_produit,this.id_categorie,this.nom_produit, this.image_produit, this.id_restau,this.prix_produit,this.unite_produit);

  produit.formJson(Map<String, dynamic> json) {
    id_produit = json['id_produit'];
    id_categorie=json['id_categorie'];
    nom_produit = json['nom_produit'];
    image_produit = json['image_produit'];
  //  print(json['prix_prod'].runtimeType);

    id_restau = json['id_restau'];
    prix_produit = json['prix_produit'].toDouble();
    unite_produit= json['unite_produit'];
  }

  Map<String, dynamic> toJson(produit pr) => {
    'id_produit': pr.id_produit,
    'id_categorie': pr.id_categorie,
    'nom_produit': pr.nom_produit,
    'image_produit': pr.image_produit,
   // 'prix_prod': pr.prix_prod,
    'id_restau': pr.id_restau,
  'prix_produit' : pr.prix_produit ,
  'unite_produit' : pr.unite_produit,

  };
}