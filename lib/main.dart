import 'dart:io';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/bloc_observer/bloc_observer.dart';
import 'package:newsapp/core/dio_service/dio_service.dart';
import 'package:newsapp/core/service/getit_service.dart';
import 'package:newsapp/core/shared_prefrences_service/shared_prefrences_service.dart';
import 'package:newsapp/presentation/controller/new_cubit.dart';
import 'package:newsapp/presentation/controller/new_states.dart';
import 'package:newsapp/presentation/screens/layouts/bottom_naavigations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetItService().init();
  if (Platform.isWindows) {
    await DesktopWindow.setMinWindowSize(const Size(400, 400));
  }
  DioService.init();
  Bloc.observer = MyBlocObserver();
  await SharedPrefrencesService.init();
  bool? saveMode = SharedPrefrencesService.getData("mode");
  runApp(MyApp(saveMode));
}

class MyApp extends StatelessWidget {
  final bool? mode;
  const MyApp(this.mode, {super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<Appcubit>()
        ..getBusiness()
        ..toogleMode(change: mode),
      child: BlocConsumer<Appcubit, NewStates>(
        builder: (context, state) {
          var app = Appcubit.get(context);
          return MaterialApp(
            themeMode: app.mode ? ThemeMode.light : ThemeMode.dark,
            theme: ThemeData(
              textTheme: const TextTheme(
                  bodyLarge: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  bodyMedium: TextStyle(
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
                  bodyLarge: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  bodyMedium: TextStyle(
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
            home: const News(),
            debugShowCheckedModeBanner: false,
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
