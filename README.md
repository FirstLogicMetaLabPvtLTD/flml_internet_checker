# Internet connectivity checking package.

A Flutter package to check your internet connection by just wrapping the Scaffold with InternetChecker Widget.

<hr />

## Permissions

### Android

Add the following permissions to your `AndroidManifest.xml` file:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

### macOS

Add the following permissions to your macOS `.entitlements` files:

```entitlements
<key>com.apple.security.network.client</key>
<true/>
```

## Usage

### 1. Add dependency

Add the `flml_internet_checker` package to your `pubspec.yaml` file:

```yaml
dependencies:
  flml_internet_checker: ^0.0.6
```

### 2. Import the package

Import the `flml_internet_checker` package into your Dart file:

```dart
import 'package:flml_internet_checker/flml_internet_checker.dart';
```

### Example

```dart
InternetChecker(
      placeHolder: Lottie.asset(
        "assets/no_internet.json",
        height: 250,
      ),
      internetConnectionText: "No Internet Connection",
      child: const Scaffold(
        body: Center(
          child: Text("You are Online"),
        ),
      ),
    );
```

## Credits

This package is a cloned and modified version of the
[internet_connection_checker_plus] package.

The aim of this package is just to check the internet connectivity without putting the functions into the project and just wrap the widget with InternetChecker Widget.

<!-- Links -->

[internet_connection_checker_plus]: https://github.com/OutdatedGuy/internet_connection_checker_plus
