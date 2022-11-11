import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/components/components.dart';
import 'package:newsapp/layouts/cubits/cubit/cubit.dart';
import 'package:newsapp/layouts/cubits/states/newstates.dart';
import 'package:newsapp/modules/search.dart';
import 'package:newsapp/network/remote/dio.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, NewStates>(
      builder: (context, state) {
        var app = Appcubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "News",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 119, 3, 139)),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    app.text[app.currentindex],
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 119, 3, 139)),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navidator(context, Search());
                },
                icon: const Icon(
                  Icons.search,
                  size: 23,
                ),
              ),
              IconButton(
                onPressed: () {
                  app.toogleMode();
                },
                icon: app.mode
                    ? const Icon(
                        Icons.sunny,
                        size: 23,
                      )
                    : const Icon(
                        Icons.dark_mode,
                        size: 23,
                      ),
              )
            ],
            automaticallyImplyLeading: false,
          ),
          body: app.page[app.currentindex],
          bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                app.bottomchange(index);
              },
              currentIndex: app.currentindex,
              items: app.bottom),
        );
      },
      listener: (context, state) {},
    );
  }
}
