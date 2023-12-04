import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/base_usecase/base_usecase.dart';
import 'package:newsapp/core/shared_prefrences_service/shared_prefrences_service.dart';
import 'package:newsapp/domain/entites/newsapp_entites.dart';
import 'package:newsapp/domain/usecases/business_usecases.dart';
import 'package:newsapp/domain/usecases/sciences_usecases.dart';
import 'package:newsapp/domain/usecases/search_usecases.dart';
import 'package:newsapp/domain/usecases/sports_usecases.dart';
import 'package:newsapp/presentation/controller/new_states.dart';
import 'package:newsapp/presentation/screens/business.dart';
import 'package:newsapp/presentation/screens/sciences.dart';
import 'package:newsapp/presentation/screens/sports.dart';

class Appcubit extends Cubit<NewStates> {
  final SportsUsecases sportsUsecases;
  final SciencesUsecases sciencesUsecases;
  final SearchUsecases searchUsecases;
  final BusinessUsecases businessUsecases;

  Appcubit(this.sciencesUsecases, this.searchUsecases, this.sportsUsecases,
      this.businessUsecases)
      : super(IniailNewStates());
  int currentindex = 0;
  int detectItem = 0;
  bool isDesktop = false;
  void changeDetectItem(value) {
    detectItem = value;
    emit(ChangeDetectItemState());
  }

  void setDesktop(value) {
    isDesktop = value;
    emit(SetDesktopState());
  }

  static Appcubit get(context) => BlocProvider.of(context);
  List<BottomNavigationBarItem> bottom = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.business_center), label: "Business"),
    BottomNavigationBarItem(icon: Icon(Icons.sports_soccer), label: "Sports"),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: "Sciences"),
  ];
  List<Widget> page = [const Business(), const Sports(), const Sciences()];
  List<String> text = ["business", "Sports", "Sciences"];
  void bottomchange(int index) {
    currentindex = index;
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getSciences();
    }
    emit(BottomChangeNewStates());
  }

  List<NewsAppEntites> business = [];
  Future getBusiness() async {
    emit(LoadingBusinessDataNewStates());
    final r = await businessUsecases.call(NoParams());
    r.fold((l) {
      emit(BusinessErrorNewStates(error: onError.toString()));
    },
        (r) => () {
              if (business.isEmpty) {
                log("message============");
                business = r;
                log("${business}==business==");

                emit(BusinessDataNewStates());
              }
            });
  }

  List<NewsAppEntites> sports = [];
  Future getSports() async {
    emit(LoadingSportsDataNewStates());
    final r = await sportsUsecases.call(NoParams());
    r.fold((l) {
      emit(SportsErrorNewStates(error: onError.toString()));
    }, (r) {
      if (sports.isEmpty) {
        log("message============");
        sports = r;
        log("${sports}===sports====");

        emit(SportsDataNewStates());
      }
    });
  }

  List<NewsAppEntites> sciences = [];
  Future getSciences() async {
    emit(LoadingSciencesDataNewStates());
    final r = await sciencesUsecases.call(NoParams());
    r.fold((l) {
      emit(ScienceErrorNewStates(error: onError.toString()));
    }, (r) {
      if (sciences.isEmpty) {
        log("message============");
        sciences = r;
        log("${sciences}===sciences====");

        emit(ScienceDataNewStates());
      }
    });
  }

  bool mode = false;
  void toogleMode({bool? change}) {
    if (change != null) {
      mode = change;
      emit(ToogleModeState());
    } else {
      mode = !mode;
      SharedPrefrencesService.putData("mode", mode);
      emit(ToogleModeState());
    }
  }

  List<NewsAppEntites> search = [];
  Future getSearch(String searchApi) async {
    emit(LoadingSearchDataNewStates());
    final r = await searchUsecases.call(SearchParameter(q: searchApi));
    r.fold((l) {
      emit(SearchErrorNewStates(error: onError.toString()));
    }, (r) {
      search = r;
      emit(SearchDataNewStates());
    });
  }
}
