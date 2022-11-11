import 'dart:io';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layouts/bottomnavigationbar/bottomnavigation.dart';
import 'package:newsapp/layouts/cubits/cubit/cubit.dart';
import 'package:newsapp/layouts/cubits/states/newstates.dart';
import 'package:newsapp/network/cubitobserver.dart';
import 'package:newsapp/network/local/cache.dart';
import 'package:newsapp/network/remote/dio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    await DesktopWindow.setMinWindowSize(const Size(400, 400));
  }
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await Cache.init();
  bool? saveMode = Cache.getData("mode");
  runApp(MyApp(saveMode));
}

class MyApp extends StatelessWidget {
  final bool? mode;
  MyApp(this.mode, {super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Appcubit()
        ..getBusiness()
        ..toogleMode(change: mode),
      child: BlocConsumer<Appcubit, NewStates>(
        builder: (context, state) {
          var app = Appcubit.get(context);
          return MaterialApp(
            themeMode: app.mode ? ThemeMode.light : ThemeMode.dark,
            theme: ThemeData(
              textTheme: const TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  bodyText2: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              appBarTheme: const AppBarTheme(
                elevation: 0.0,
                // toolbarTextStyle: TextStyle(color: Colors.black),
                backgroundColor: Colors.white,
                iconTheme:
                    IconThemeData(color: Color.fromARGB(255, 119, 3, 139)),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark),
              ),
              scaffoldBackgroundColor: Colors.white,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  unselectedItemColor: Colors.black,
                  backgroundColor: Colors.white,
                  elevation: 55,
                  selectedItemColor: Color.fromARGB(255, 119, 3, 139),
                  type: BottomNavigationBarType.fixed),
            ),
            darkTheme: ThemeData(
              appBarTheme: const AppBarTheme(
                elevation: 0.0,
                // toolbarTextStyle: TextStyle(color: Colors.black),
                backgroundColor: Colors.black,
                iconTheme:
                    IconThemeData(color: Color.fromARGB(255, 119, 3, 139)),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.black,
                    statusBarIconBrightness: Brightness.light),
              ),
              textTheme: const TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  bodyText2: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              scaffoldBackgroundColor: Colors.black,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: Colors.black.withOpacity(0.4),
                  elevation: 55,
                  unselectedItemColor: Colors.white,
                  selectedItemColor: const Color.fromARGB(255, 119, 3, 139),
                  type: BottomNavigationBarType.fixed),
            ),
            home: News(),
            debugShowCheckedModeBanner: false,
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
