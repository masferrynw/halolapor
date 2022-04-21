import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/error_page.dart';
import 'app/utils/loading_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorPage();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GetMaterialApp(
                  title: "Halo Lapor",
                  initialRoute: AppPages.INITIAL,
                  getPages: AppPages.routes,
                );
              }
            },
          );
        }
        return LoadingPage();
      },
    );
  }
}
