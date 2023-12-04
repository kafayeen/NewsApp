import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/presentation/controller/new_cubit.dart';
import 'package:newsapp/presentation/controller/new_states.dart';

import '../components/components.dart';

class Search extends StatelessWidget {
  final TextEditingController field = TextEditingController();
  final bool isToggle = true;

  Search({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, NewStates>(
        builder: (context, state) {
          var list = Appcubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title: const Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "News",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 119, 3, 139)),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "Search",
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 119, 3, 139)),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      list.toogleMode();
                    },
                    icon: list.mode
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
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: defaultField(
                        functionValidator: (String? value) {
                          if (value!.isEmpty) {
                            return "must not null";
                          }
                          return null;
                        },
                        context: context,
                        labelText: "Search",
                        icon: Icons.search,
                        type: TextInputType.text,
                        onchange: (value) {
                          list.getSearch(value);
                        },
                        controller: field),
                  ),
                  Expanded(
                    child: ConditionalBuilder(
                      builder: (context) => ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return item(list.search[index], context, index);
                          },
                          separatorBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(start: 10.0),
                              child: Container(
                                width: 1,
                                height: 1,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 119, 3, 139)),
                              ),
                            );
                          },
                          itemCount: list.search.length),
                      condition: list.search.isNotEmpty,
                      fallback: (context) {
                        return isToggle
                            ? Container()
                            : const Center(
                                child: CircularProgressIndicator(
                                  color: Color.fromARGB(255, 119, 3, 139),
                                ),
                              );
                      },
                    ),
                  ),
                ],
              ));
        },
        listener: (context, state) {});
  }
}
