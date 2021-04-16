import 'package:ecommerce_outlet_app_565/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class SaveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        Center(
          child: Text("Saved Tab"),
        ),
        CustomActionBar(
          title: "Saved",
          // hasTitle: false,
          hasBackArrrow: true,
        ),
      ],
    ));
  }
}
