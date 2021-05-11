import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_outlet_app_565/Services/firebase_services.dart';
import 'package:ecommerce_outlet_app_565/widgets/custom_action_bar.dart';
import 'package:ecommerce_outlet_app_565/widgets/custom_button.dart';
import 'package:ecommerce_outlet_app_565/widgets/custom_input.dart';
import 'package:ecommerce_outlet_app_565/widgets/store_cart.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rsa_encrypt/rsa_encrypt.dart';
import 'package:pointycastle/api.dart' as crypto;
import 'package:flutter/material.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:ecommerce_outlet_app_565/Services/firebase_services.dart';

import '../constants.dart';

class FilterTab extends StatefulWidget {
  @override
  _FilterTabState createState() => _FilterTabState();
}

class _FilterTabState extends State<FilterTab> {
  String _randomKey = 'Unknown';
  String _string = "Unknown";
  String _encrypted = "Unknown";
  Future<dynamic> _keyPair;

  //Future to hold our KeyPair
  Future<crypto.AsymmetricKeyPair> futureKeyPair;

  //to store the KeyPair once we get data from our future
  crypto.AsymmetricKeyPair keyPair;

  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Close Dialog"),
              )
            ],
          );
        });
  }

  Future<String> _encryptDatabaseInfo() async {
    try {
      print("call encryptDatabaseInfo");
      print("encrypted value -> 71");
      print(_encrypted);
      FirebaseServices _firebaseServices = FirebaseServices();
      await _firebaseServices.usersRef
          // doesnt like getUserID because the user doesnt have an id yet?
          .doc(_firebaseServices.getUserId())
          //.doc('/Users/I27BrulW4qdxOBzi2YgJObeYyX73')
          .collection("Info")
          .doc()
          .set({"name": _encrypted});
      return "done";
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

  // ENCRYPTION CODE

  // //Future to hold our KeyPair
  // Future<crypto.AsymmetricKeyPair> futureKeyPair;
  //
  // //to store the KeyPair once we get data from our future
  // crypto.AsymmetricKeyPair keyPair;

  Future<crypto.AsymmetricKeyPair<crypto.PublicKey, crypto.PrivateKey>>
      getKeyPair() {
    var helper = RsaKeyHelper();
    return helper.computeRSAKeyPair(helper.getSecureRandom());
  }

  encryptText(String text) async {
    print("call encryptText -> 102");
    var word = "hello";

    futureKeyPair = getKeyPair();
    print("key pair");
    print(futureKeyPair); // last printed line
    // think it returns here
    keyPair = await futureKeyPair;
    print("keyPair");
    print(keyPair);
    // var helper = RsaKeyHelper();
    // var public = helper.encodePublicKeyToPemPKCS1(keyPair.publicKey);
    // var private = helper.encodePrivateKeyToPemPKCS1(keyPair.privateKey);
    //
    // var encryptWord = encrypt(text, keyPair.publicKey);
    // print("encryptWord -> 87");
    //
    // print(encryptWord);
    // var decryptWord = decrypt(text, keyPair.privateKey);
    // print("decryptWord -> 91");
    // print(decryptWord);
    //
    // return encryptWord;
  }

  void _submitForm() async {
    print("call submitForm");
    // Set the form to loading state
    setState(() {
      _registerFormLoading = true;
    });
    // problem line

    var the = encryptText(_name);
    print("the -> 137");
    print(the);
    print("encrypted -> 176");
    print(_encrypted);
    // var helper = RsaKeyHelper();
    // var public = helper.encodePublicKeyToPemPKCS1(keyPair.publicKey);
    // var private = helper.encodePrivateKeyToPemPKCS1(keyPair.privateKey);

    _encrypted = encrypt(_name, the.publicKey);
    print("encryptWord -> 87");

    print(_encrypted);
    // var decryptWord = decrypt(text, keyPair.privateKey);
    // print("decryptWord -> 91");
    // print(decryptWord);

    // Set the create account method
    String _createAccountFeddback = await _encryptDatabaseInfo();
    print("_createAccountFeddback -> 130" + _createAccountFeddback);
    String _encryptInfo = _createAccountFeddback;

    print("encryptInfo");
    print(_encryptInfo);
    // if String is not null, there was an error creating account
    if (_encryptInfo != null) {
      // _createAccountFeddback != null ||
      _alertDialogBuilder(_encryptInfo);

      // Set the from to regular state [not loading]
      setState(() {
        _registerFormLoading = false;
      });
    } else {
      // the string was null, user is logged in, head back to login page
      Navigator.pop(context);
    }
  }

  // Default Form Loading State
  bool _registerFormLoading = false;

  // Form Input Field Values
  String _registerEmail = "";
  String _registerPassword = "";
  String _name = "";
  String _number = "";

  // Focus Node for Input Fields
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
    // initPlatformState();
    //encrypted();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 24.0,
                ),
                child: Text(
                  "Add Information to Account",
                  textAlign: TextAlign.center,
                  style: Constants.bold_heading,
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: "Name",
                    onChanged: (value) {
                      _name = value;
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    hintText: "Number",
                    onChanged: (value) {
                      _number = value;
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  // CustomInput(
                  //   hintText: "Email...",
                  //   onChanged: (value) {
                  //     _registerEmail = value;
                  //   },
                  //   onSubmitted: (value) {
                  //     _passwordFocusNode.requestFocus();
                  //   },
                  //   textInputAction: TextInputAction.next,
                  // ),
                  // CustomInput(
                  //   hintText: "Password...",
                  //   onChanged: (value) {
                  //     _registerPassword = value;
                  //   },
                  //   focusNode: _passwordFocusNode,
                  //   isPasswordField: true,
                  //   onSubmitted: (value) {
                  //     _submitForm();
                  //   },
                  // ),
                  CustomButton(
                    text: "Sumbit",
                    onPressed: () {
                      _submitForm();
                    },
                    isLoading: _registerFormLoading,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                ),
                /*child: CustomButton(
                  text: "Back To Login",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  outlineButton: true,
                ),*/
              ),
            ],
          ),
        ),
      ),
    );
  }
}
