import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layouts/cubits/cubit/cubit.dart';
import 'package:newsapp/layouts/cubits/states/newstates.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shimmer/shimmer.dart';

import '../components/components.dart';

class Business extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, NewStates>(
        builder: (context, state) {
          var list = Appcubit.get(context).business;
          return ConditionalBuilder(
              condition: list.isNotEmpty,
              builder: (context) {
                return ScreenTypeLayout(
                  breakpoints: const ScreenBreakpoints(
                      desktop: 600, tablet: 124, watch: 100),
                  desktop: Builder(builder: (context) {
                    Appcubit.get(context).setDesktop(true);
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return item(list[index], context, index);
                              },
                              separatorBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 10.0),
                                  child: Container(
                                    width: 1,
                                    height: 1,
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 119, 3, 139)),
                                  ),
                                );
                              },
                              itemCount: list.length),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            Appcubit.get(context)
                                    .business[Appcubit.get(context).detectItem]
                                ["description"],
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ))
                      ],
                    );
                  }),
                  mobile: Builder(builder: (context) {
                    Appcubit.get(context).setDesktop(false);
                    return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return item(list[index], context, index);
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
                        itemCount: list.length);
                  }),
                );
              },
              fallback: (context) {
                return Center(
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          height: 5,
                          color: Colors.grey,
                        ),
                      )),
                );
              });
        },
        listener: (context, state) {});
  }
}
