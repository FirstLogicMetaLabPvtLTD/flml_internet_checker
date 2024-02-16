Internet connectivity checking package.

## Usage

```dart
import 'package:flml_internet_checker/flml_internet_checker.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const InternetChecker(
      child: Scaffold(
        body: Center(
          child: Text("DATA"),
        ),
      ),
    );
  }
}
```