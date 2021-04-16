import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_outlet_app_565/Services/firebase_services.dart';
import 'package:ecommerce_outlet_app_565/widgets/image_swipe.dart';
import 'package:ecommerce_outlet_app_565/widgets/product_size.dart';
import 'package:ecommerce_outlet_app_565/widgets/Product_cart.dart';
import 'package:ecommerce_outlet_app_565/widgets/custom_input.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../constants.dart';
import '../widgets/custom_action_bar.dart';

class productPage extends StatefulWidget {
  final String prodcutID;
  productPage({this.prodcutID});

  @override
  _productPageState createState() => _productPageState();
}

class _productPageState extends State<productPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String _searchString = "red";

  String _selectedProductSize = "0";

  Future addToCart() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.prodcutID)
        .set({"size": _selectedProductSize});
  }

  addRec() {
    print("-> 36");

    _firebaseServices.prodductsRef
        .orderBy("search_string")
        .startAt([_searchString]).endAt(["$_searchString\uf8ff"]).get();
    builder:
    (context, snapshot) {
      if (snapshot.hasError) {
        print("-> 44");
        return Scaffold(
          body: Center(
            child: Text("Error: ${snapshot.error}"),
          ),
        );
      }

      // Collection Data ready to display
      if (snapshot.connectionState == ConnectionState.done) {
        print("-> 54");
        // Display the data inside a list view
        return ListView(
          padding: EdgeInsets.only(
            top: 128.0,
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
    };
    // by the end hope to return a list view of filtered items
  }

  final SnackBar _snackBar = SnackBar(
    content: Text("Product added to the cart "),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.prodductsRef.doc(widget.prodcutID).get(),
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
                Map<String, dynamic> documentData = snapshot.data.data();

                // list of images
                List imageList = documentData['images'];
                List productSizes = documentData['sizes'];
                String recSearchList = documentData['search_string'];
                // Make a list of the clicked on products "search_id" = recSearchList
                // loop through database products
                // nest loop look through products seach_id
                // if products seach_id in list of recSearchList add to recImageList
                List recImageList = documentData['images'];

                // set an  initial size
                _selectedProductSize = productSizes[0];

                // loop through tables in database

                return ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    // Product Images
                    ImageSwipe(
                      imageList: imageList,
                    ),
                    // Product name
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24.00,
                        bottom: 4.0,
                        left: 24.0,
                        right: 24.0,
                      ),
                      child: Text(
                        "${documentData['name']}" ?? "Product Name",
                        style: Constants.bold_heading,
                      ),
                    ),
                    // Product Price
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        "\$${documentData['price']}" ?? "Price",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // Product Details
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        "${documentData['details']}",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    // Product Sizes
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        "Select Sizes",
                        style: Constants.regDarkText,
                      ),
                    ),
                    productSize(
                      productSizes: productSizes,
                      onSelected: (size) {
                        _selectedProductSize = size;
                      },
                    ),
                    // Save & Add to cart
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
                                await addToCart();
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
                    ),
                    // Product Recommendation name
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24.00,
                        bottom: 4.0,
                        left: 24.0,
                        right: 24.0,
                      ),
                      child: Text(
                        "${documentData['name']}" ?? "Product Name",
                        style: Constants.bold_heading,
                      ),
                    ),
                    // Product Recommendation

                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                await addRec();
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
                                  "Recommendations",
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
                    ),
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
