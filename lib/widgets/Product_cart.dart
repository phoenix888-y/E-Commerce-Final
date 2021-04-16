import 'package:ecommerce_outlet_app_565/screens/Product_page.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ProductCart extends StatelessWidget {
  final String productID;
  final Function onPressed;
  final String imageURL;
  final String title;
  final String price;
  final String storeID;

  ProductCart(
      {this.onPressed,
      this.imageURL,
      this.price,
      this.title,
      this.productID,
      this.storeID});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => productPage(
                prodcutID: productID,
                //storeID: storeID
              ),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        height: 350.0,
        margin: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: [
            Container(
              height: 350.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  "$imageURL",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: Constants.regular_heading,
                    ),
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    ;
    ;
  }
}
