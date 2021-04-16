import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_outlet_app_565/screens/Product_page.dart';
import 'package:ecommerce_outlet_app_565/widgets/Product_cart.dart';
import 'package:ecommerce_outlet_app_565/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class ProductTab extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              // Collection Data ready to display
              if (snapshot.connectionState == ConnectionState.done) {
                // Display the data inside a list view
                return ListView(
                  padding: EdgeInsets.only(
                    top: 108.0,
                    bottom: 12.0,
                  ),
                  children: snapshot.data.docs.map((document) {
                    return ProductCart(
                      title: document.data()['name'],
                      imageURL: document.data()['images'][0],
                      price: "\$${document.data()['price']}",
                      productID: document.id,
                    );
                  }).toList(),
                );
              }

              // Loading State
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            title: "Product",
            hasBackArrrow: false,
          ),
        ],
      ),
    );
  }
}
