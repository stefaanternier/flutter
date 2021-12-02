#Youplay mobile player

The purpose of this document is to help you started with building and compiling the mobile player.

## Prerequisites and tools

Programming environment:
* Dart: https://dart.dev/guides/language/language-tour
* Flutter: https://flutter.dev/

This player depends heavily on the redux framework.
Read more about the redux priniciples here:
https://redux.js.org/understanding/thinking-in-redux/three-principles

Library-wise, support is offered by
* flutter_redux is a set of tools to set up and manipulate the redux store and state.
* RxDart for advanced Stream manipulaties
* reselect for retrieval and memoizing computed values from the state


## Model view controller

All ui files have the following structure:
* file.dart
* file.container.dart

In this representations the `*.container.dart` file is responsible for
both the controller part. It fetches data from the store and injects it 
into it's `*.dart` counterpart. In this convention, the `file.dart` file 
represents the view and is unaware of how data is to be stored or how
user events are to be handled.

## Configure and setup of project.

### Android

All android build files are generated within the android folder.
The following files require modifications
* build.gradle (see firebase installation)
* app/build.gradle (see firebase installation)
* app/google-services.json (see firebase installation)


```aidl

flutter build appbundle -t lib/demo.main.dart

```

### iOS

iOS build files are generated under  ios
The following file should be installed (see firebase installation)
* ios/Runner/GoogleService-Info.plist

```aidl

flutter build ios -t lib/demo.main.dart
```

other usefull commands

```aidl
pod install
pod install --repo-update
```


### web

See web folder and index.html for firebase configuration.

The following command will build web files into this folder.
```aidl
flutter build web -t lib/demo.main.dart
```

