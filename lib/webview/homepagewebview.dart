import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class websiteHomePage extends StatefulWidget {
  @override
  _websiteHomePageState createState() => _websiteHomePageState();
}

class _websiteHomePageState extends State<websiteHomePage> {
  String _networkStatus1 = '';

  Connectivity connectivity = Connectivity();

  void checkConnectivity() async {
    var connectivityResult = await connectivity.checkConnectivity();
    var conn = getConnectionValue(connectivityResult);
    setState(() {
      _networkStatus1 = '' + conn;
    });
  }

// Method to convert the connectivity to a string value
  String getConnectionValue(var connectivityResult) {
    String status = '';
    switch (connectivityResult) {
      case ConnectivityResult.mobile:
        status = 'Mobile';
        break;
      case ConnectivityResult.wifi:
        status = 'Wi-Fi';
        break;
      case ConnectivityResult.none:
        status = 'None';
        break;
      default:
        status = 'None';
        break;
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    checkConnectivity();
    if (_networkStatus1 == 'None') {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: AlertDialog(
            title: const Text('Bağlantı Kesildi'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Bağlantınızı kontrol ediniz.'),
                  Text("Tamam'a bastığınızda çıkış gerçekleşecek."),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Tamam'),
                onPressed: () {
                  exit(0);
                },
              ),
            ],
          ),
        ),
      );
    }
    if (_networkStatus1 == 'Wi-Fi' || _networkStatus1 == 'Mobile') {
      return WebviewScaffold(
        url: 'https://inodya.com/',
        withJavascript: true,
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
    );
  }
}
