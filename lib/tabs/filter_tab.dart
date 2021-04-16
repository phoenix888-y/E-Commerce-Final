import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_outlet_app_565/widgets/custom_action_bar.dart';
import 'package:ecommerce_outlet_app_565/widgets/store_cart.dart';
import 'package:flutter/material.dart';

class FilterTab extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");

  final CollectionReference _storeRef =
      FirebaseFirestore.instance.collection("Stores");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _storeRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              // // Collection Data ready to display
              // if (snapshot.connectionState == ConnectionState.done) {
              //   // Display the data inside a list view
              //   return ListView(
              //     padding: EdgeInsets.only(
              //       top: 108.0,
              //       bottom: 12.0,
              //     ),
              //     children: snapshot.data.docs.map((document) {
              //       return StoreCart(
              //         title: document.data()['name'],
              //         imageURL: document.data()['images'][0],
              //
              //         //productID: document.id,
              //       );
              //     }).toList(),
              //   );
              // }

              // Loading State
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            title: "Stores",
            hasBackArrrow: false,
          ),
        ],
      ),
    );
  }
}
