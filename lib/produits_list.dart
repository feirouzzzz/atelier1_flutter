import 'package:flutter/material.dart';
import 'produit_box.dart';
import 'add_produit.dart';

class ProduitsList extends StatefulWidget {
  const ProduitsList({super.key});

  @override
  State<ProduitsList> createState() => _ProduitsListState();
}

class _ProduitsListState extends State<ProduitsList> {
  List<List<dynamic>> liste = [
    ['1 Produit', false],
    ['2 Produit', true],
    ['3 Produit', false],
    ['4 Produit', false],
    ['5 Produit', false],
  ];

  final TextEditingController nomController = TextEditingController();

  void onChanged(bool? value, int index) {
    setState(() {
      liste[index][1] = value ?? false;
    });
  }

  void addProduct() {
    showDialog(
      context: context,
      builder: (context) {
        return AddProduit(
          nomController: nomController,
          onAdd: () {
            setState(() {
              liste.add([nomController.text, false]);
              nomController.clear();
              Navigator.pop(context);
            });
          },
          onCancel: () {
            Navigator.pop(context);
            nomController.clear();
          },
        );
      },
    );
  }

  void delProduit(int index) {
    setState(() {
      liste.removeAt(index);
    });
  }

  void deleteSelectedProducts() {
    setState(() {
      liste.removeWhere((product) => product[1] == true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produits"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: deleteSelectedProducts,
            tooltip: 'Supprimer les produits sélectionnés',
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: liste.length,
        itemBuilder: (context, index) {
          return ProduitBox(
            nomProduit: liste[index][0],
            selProduit: liste[index][1],
            onChanged: (value) => onChanged(value, index),
            delProduit: (context) => delProduit(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addProduct,
        child: const Icon(Icons.add),
      ),
    );
  }
}
