import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class InternetChecker extends StatefulWidget {
  final Widget _child;
  final String _retryText;
  final String _internetConnectionText;
  final String _noInternetSnackBarText;
  final Color _btnColor;
  const InternetChecker({
    super.key,
    required Widget child,
    String? retryText,
    String? internetConnectionText,
    String? noInternetSnackBarText,
    Color? btnColor,
  })  : _retryText = retryText ?? "Retry",
        _internetConnectionText =
            internetConnectionText ?? "No Internet Connection",
        _btnColor = btnColor ?? Colors.black,
        _noInternetSnackBarText =
            noInternetSnackBarText ?? "No Active Connection Found",
        _child = child;

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

  var isDeviceConnected = false;

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  getConnection() async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    setState(() {});
    // ref
    //     .watch(isDeviceConnectedProvider.notifier)
    //     .update((state) => isDeviceConnected);
    if (isDeviceConnected == true) {
      _btnController.success();
    } else {
      _btnController.stop();
      if (mounted) {
        showSnackBar(context, widget._noInternetSnackBarText);
      }
    }

    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      _btnController.stop();
      if (result != ConnectivityResult.none) {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        setState(() {});
        // ref
        //     .watch(isDeviceConnectedProvider.notifier)
        //     .update((state) => isDeviceConnected);
      } else {
        _btnController.reset();
        isDeviceConnected = false;
        setState(() {});
        // ref.watch(isDeviceConnectedProvider.notifier).update((state) => false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getConnection();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return isDeviceConnected == false
        ? Scaffold(
            body: SafeArea(
            child: Container(
                color: Colors.white,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Lottie.asset(
                            "packages/flml_internet_checker/assets/no_internet.json",
                            height: 250),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget._internetConnectionText,
                        style: GoogleFonts.poppins(
                            fontSize: w * 0.035,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RoundedLoadingButton(
                          height: h * 0.06,
                          width: w * 0.4,
                          errorColor: Colors.red,
                          successColor: Colors.green,
                          controller: _btnController,
                          color: widget._btnColor,
                          onPressed: () {
                            getConnection();
                          },
                          child: Text(widget._retryText,
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 16))),
                    ])),
          ))
        : widget._child;
  }
}
