import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layouts/cubits/states/newstates.dart';
import 'package:newsapp/modules/business.dart';
import 'package:newsapp/modules/sciences.dart';
import 'package:newsapp/modules/sports.dart';
import 'package:newsapp/network/local/cache.dart';
import 'package:newsapp/network/remote/dio.dart';

class Appcubit extends Cubit<NewStates> {
  Appcubit() : super(IniailNewStates());
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
  List<Widget> page = [Business(), Sports(), Sciences()];
  List<String> text = ["business", "Sports", "Sciences"];
  void bottomchange(int index) {
    currentindex = index;
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getSciences();
    }
    emit(bottomChangeNewStates());
  }

  List<dynamic> business = [];
  void getBusiness() {
    DioHelper.get(url: "v2/top-headlines", query: {
      "country": "us",
      "category": "business",
      "apiKey": "a7ba871b67214025915dc7ab566f86e8",
    }).then((value) {
      business = value.data['articles'];
      print(value.data["articles"]);
      emit(businessDataNewStates());
    }).catchError((onError) {
      print(onError.toString());
      emit(businessErrorNewStates(error: onError.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    if (sports.isEmpty) {
      DioHelper.get(url: "v2/top-headlines", query: {
        "country": "us",
        "category": "sports",
        "apiKey": "a7ba871b67214025915dc7ab566f86e8",
      }).then((value) {
        sports = value.data['articles'];
        emit(sportsDataNewStates());
      }).catchError((onError) {
        print(onError.toString());
        emit(sportsErrorNewStates(error: onError.toString()));
      });
    } else {
      emit(sportsDataNewStates());
    }
  }

  List<dynamic> sciences = [];
  void getSciences() {
    if (sciences.length == 0) {
      DioHelper.get(url: "v2/top-headlines", query: {
        "country": "us",
        "category": "science",
        "apiKey": "a7ba871b67214025915dc7ab566f86e8",
      }).then((value) {
        sciences = value.data["articles"];
        emit(scienceDataNewStates());
      }).catchError((onError) {
        print(onError.toString());
        emit(scienceErrorNewStates(error: onError.toString()));
      });
    } else {
      emit(scienceDataNewStates());
    }
  }

  bool mode = false;
  void toogleMode({bool? change}) {
    if (change != null) {
      mode = change;
      emit(toogleModeState());
    } else {
      mode = !mode;
      Cache.putData("mode", mode);
      emit(toogleModeState());
    }
  }

  List<dynamic> search = [];
  void getSearch(String searchApi) {
    DioHelper.get(url: "v2/everything", query: {
      "q": searchApi,
      "apiKey": "a7ba871b67214025915dc7ab566f86e8",
    }).then((value) {
      search = value.data["articles"];
      emit(searchDataNewStates());
    }).catchError((onError) {
      print(onError.toString());
      emit(searchErrorNewStates(error: onError.toString()));
    });
  }
}
