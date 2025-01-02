import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetChecker extends StatefulWidget {
  final Widget _child;
  final Widget _placeHolder;
  final String _internetConnectionText;
  final TextStyle _textStyle;
  const InternetChecker({
    Key? key,
    required Widget child,
    required Widget placeHolder,
    String? internetConnectionText,
    TextStyle? textStyle,
  })  : _internetConnectionText =
            internetConnectionText ?? "No Internet Connection",
        _placeHolder = placeHolder,
        _textStyle = textStyle ??
            const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
        _child = child,
        super(key: key);

  @override
  State createState() => _InternetCheckPageState();
}

class _InternetCheckPageState extends State<InternetChecker> {
  // final isDeviceConnectedProvider = StateProvider.autoDispose<bool>((ref) {
  //   return false;
  // });
  void showSnackBar(BuildContext context, String text) {
    if (context.mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: Colors.black,
            content: Text(text),
          ),
        );
    }
  }

  var isDeviceConnected = true;
  StreamSubscription? listener;

  getConnection() {
    listener =
        InternetConnection().onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:
          // The internet is now connected
          isDeviceConnected = true;
          setState(() {});
          break;
        case InternetStatus.disconnected:
          // The internet is now disconnected
          isDeviceConnected = false;
          setState(() {});
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getConnection();
  }

  @override
  void dispose() {
    listener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isDeviceConnected == false
        ? Scaffold(
            body: SafeArea(
            child: Container(
                color: Colors.white,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: widget._placeHolder,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget._internetConnectionText,
                        style: widget._textStyle,
                      ),
                    ])),
          ))
        : widget._child;
  }
}
