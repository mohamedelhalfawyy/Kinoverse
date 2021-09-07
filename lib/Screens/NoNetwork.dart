import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kinoverse/Services/SharedInformation_Services.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class NoNetworkScreen extends StatefulWidget {
  static const String id = 'NoNetworkScreen';

  @override
  _NoNetworkScreenState createState() => _NoNetworkScreenState();
}

class _NoNetworkScreenState extends State<NoNetworkScreen> {
  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          opacity: 0.5,
          progressIndicator: Lottie.asset('assets/indicator.json',
              height: 130, fit: BoxFit.cover, animate: true, repeat: true),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'No Internet Connection!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Expanded(
                    child: Lottie.asset(
                      'assets/noInternet.json',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future checkConnection() async {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult _result) async {
      if (_result == ConnectivityResult.mobile ||
          _result == ConnectivityResult.wifi) {
        log('connected to internet');

         await Firebase.initializeApp();

         bool? _isUser = await SharedInformation().isLoggedIn();

        // _isUser!
        //     ? Navigator.pushReplacementNamed(context, DashBoard.id)
        //     : Navigator.pushReplacementNamed(context, SignIn.id);
      }
    });
  }
}