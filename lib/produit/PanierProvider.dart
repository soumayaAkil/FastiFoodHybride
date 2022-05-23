import 'package:flutter/widgets.dart';


import '../Models/ModelPanierProd.dart';


class PanierProvider extends ChangeNotifier {

  List<PanierProduit> produits = [];
  double totale = 0;

  void addProduit(PanierProduit newProduit) {

    Iterable<PanierProduit>  test = produits.where((element) => element.selectedProduit == newProduit.selectedProduit);

    if (test.isEmpty) {
      produits.add(newProduit);
      totale = totale + newProduit.somme;
      notifyListeners();
    }
  }

  void clearProduit(){
    produits.clear();
    totale = 0;
    notifyListeners();
  }



}
