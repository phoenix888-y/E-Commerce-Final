import 'package:ecommerce_outlet_app_565/constants.dart';
import 'package:ecommerce_outlet_app_565/screens/home_page.dart';
import 'package:ecommerce_outlet_app_565/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, futureSnapshot) {
        // if snapshot has error
        if (futureSnapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${futureSnapshot.error}"),
            ),
          );
        }

        // Connection Initialized  - Firebase App is running
        if (futureSnapshot.connectionState == ConnectionState.done) {

          // StreamBuilder checks the login state live
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
              // if streamSnapshot has error
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${streamSnapshot.error}"),
                  ),
                );
              }

              //if FirebaseAuth is working
              //Connection state active - preforming the user login check
              if(streamSnapshot.connectionState == ConnectionState.active) {

                // Get the user
                // returns if we got the user
                User _user = streamSnapshot.data;

                // If user is null, not logged in
                if (_user == null) {
                  // user not logged in, go to login page
                  return LoginPage();
                } else {
                  //user logged in
                  // go to home page
                  return HomePage();
                }
              }

              //Checking the auth state - Loading
              return Scaffold(
                body: Center(
                  child: Text("Checking Authentication...",
                    style: Constants.regular_heading,
                  ),
                ),
              );
            },
          );
        }

        //Connecting to firebase - Loading
        return Scaffold(
          body: Center(
            child: Text("Initializing App...",
              style: Constants.regular_heading,
            ),
          ),
        );
      },
    );
  }
}
