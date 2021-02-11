import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testbloc/bloc/card/cardBloc.dart';
import 'package:testbloc/bloc/posts/postsBloc.dart';
import 'package:testbloc/screen/errorScreen.dart';
import 'package:testbloc/screen/firstScreen.dart';
import 'package:testbloc/screen/splashScreen.dart';
import 'package:testbloc/services/dataService.dart';
import 'package:testbloc/services/repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future initApp() async {
    await DataService.init();
  }

  @override
  Widget build(BuildContext context) {
    final repository = Repository();

    Widget resultWidget = SplashScreenWidget();

    return MaterialApp(
      theme: ThemeData(
        accentColor: Colors.orange,
      ),
      home: FutureBuilder(
        future: initApp(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            resultWidget = ErrorScreenWidget();
          } else if (snapshot.connectionState == ConnectionState.done) {
            resultWidget = MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => PostsBloc(repository)),
                BlocProvider(create: (context) => CardBloc())
              ],
              child: FirstScreenWidget(),
            );
          }
          return resultWidget;
        },
      ),
    );
  }
}
