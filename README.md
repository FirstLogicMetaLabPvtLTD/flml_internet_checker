Internet connectivity checking package.

## Usage

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