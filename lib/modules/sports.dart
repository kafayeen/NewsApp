import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layouts/cubits/cubit/cubit.dart';
import 'package:newsapp/layouts/cubits/states/newstates.dart';

import '../components/components.dart';

class Sports extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, NewStates>(
        builder: (context, state) {
          var list = Appcubit.get(context).sports;

          return ConditionalBuilder(
              condition: list.isNotEmpty,
              builder: (context) {
                return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return item(list[index], context, index);
                    },
                    separatorBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsetsDirectional.only(start: 10.0),
                        child: Container(
                          width: 1,
                          height: 1,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 119, 3, 139)),
                        ),
                      );
                    },
                    itemCount: list.length);
              },
              fallback: (context) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 119, 3, 139),
                  ),
                );
              });
        },
        listener: (context, state) {});
  }
}
