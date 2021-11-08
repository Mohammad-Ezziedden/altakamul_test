import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';
part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityHelper {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? connectivitySubscribtion;
  bool isConnected = false;
  ConnectivityHelper() {
    initConectivity();
  }

  Future<void> initConectivity() async {
    try {
      var result = await _connectivity.checkConnectivity();

      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        isConnected = true;
      } else {
        isConnected = false;
      }

      connectivitySubscribtion ??=
          _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    } on PlatformException catch (e) {
      print(e.toString());
      isConnected = false;
    }
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        isConnected = true;

        break;
      default:
        isConnected = false;

        break;
    }
  }
}
