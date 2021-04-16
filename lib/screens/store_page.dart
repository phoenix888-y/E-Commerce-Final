import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_outlet_app_565/Services/firebase_services.dart';
import 'package:ecommerce_outlet_app_565/tabs/product_tab.dart';
import 'package:ecommerce_outlet_app_565/widgets/image_swipe.dart';
import 'package:ecommerce_outlet_app_565/widgets/product_size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../constants.dart';
import '../widgets/custom_action_bar.dart';

class storePage extends StatefulWidget {
  final String storeID;
  storePage({this.storeID});

  @override
  _storePageState createState() => _storePageState();
}

class _storePageState extends State<storePage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _selectedProductSize = "0";

  // Future addToCart() {
  //   return _firebaseServices.usersRef
  //       .doc(_firebaseServices.getUserId())
  //       .collection("Cart")
  //       .doc(widget.storeID)
  //       //.set({"size": _selectedProductSize});
  //       .set({"name": _selectedProductSize});
  // }

  final SnackBar _snackBar = SnackBar(
    content: Text("Product added to the cart "),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.storesRef.doc(widget.storeID).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                // firebase document data map
                // snapshot.data.docs.map((document)
                Map<String, dynamic> documentData = snapshot.data.data();
                print("IT TRYING");

                print(documentData);
                print("done printing");
                // list of images
                List imageList = documentData['images'];
                //List productSizes = documentData['sizes'];
                print("worked");
                // set an  initial size
                //_selectedProductSize = productSizes[0];

                return ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    ImageSwipe(
                      imageList: imageList,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24.00,
                        bottom: 4.0,
                        left: 24.0,
                        right: 24.0,
                      ),
                      child: Text(
                        "${documentData['name']}" ?? "Store Name",
                        style: Constants.bold_heading,
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //     vertical: 4.0,
                    //     horizontal: 24.0,
                    //   ),
                    //   child: Text(
                    //     "\$${documentData['price']}" ?? "Price",
                    //     style: TextStyle(
                    //       fontSize: 18.0,
                    //       color: Theme.of(context).accentColor,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //     vertical: 8.0,
                    //     horizontal: 24.0,
                    //   ),
                    //   child: Text(
                    //     "${documentData['description']}",
                    //     style: TextStyle(
                    //       fontSize: 18.0,
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //     vertical: 24.0,
                    //     horizontal: 24.0,
                    //   ),
                    //   child: Text(
                    //     "Select Sizes",
                    //     style: Constants.regDarkText,
                    //   ),
                    //),
                    // productSize(
                    //   productSizes: productSizes,
                    //   onSelected: (size) {
                    //     _selectedProductSize = size;
                    //   },
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 65.0,
                            height: 65.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFDCDCDC),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            alignment: Alignment.center,
                            child: Image(
                              image: AssetImage(
                                "assets/images/tab_saved.png",
                              ),
                              height: 21.0,
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                // await addToCart();
                                ProductTab();
                                Scaffold.of(context).showSnackBar(_snackBar);
                              },
                              child: Container(
                                height: 65.0,
                                margin: EdgeInsets.only(
                                  left: 16.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Add To Cart",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              }
              //loading state
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            hasBackArrrow: true,
            hasTitle: false,
            hasBackground: false,
          )
        ],
      ),
    );
  }
}
