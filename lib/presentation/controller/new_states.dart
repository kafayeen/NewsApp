abstract class NewStates {}

class IniailNewStates extends NewStates {}

class BottomChangeNewStates extends NewStates {}

class BusinessDataNewStates extends NewStates {}

class LoadingBusinessDataNewStates extends NewStates {}

class LoadingSearchDataNewStates extends NewStates {}

class LoadingSciencesDataNewStates extends NewStates {}

class LoadingSportsDataNewStates extends NewStates {}

class BusinessErrorNewStates extends NewStates {
  final String? error;
  BusinessErrorNewStates({required this.error});
}

class SportsDataNewStates extends NewStates {}

class SportsErrorNewStates extends NewStates {
  final String? error;
  SportsErrorNewStates({required this.error});
}

class SearchDataNewStates extends NewStates {}

class SearchErrorNewStates extends NewStates {
  final String? error;
  SearchErrorNewStates({required this.error});
}

class ScienceDataNewStates extends NewStates {}

class ScienceErrorNewStates extends NewStates {
  final String? error;
  ScienceErrorNewStates({required this.error});
}

class ToogleModeState extends NewStates {}

class ChangeDetectItemState extends NewStates {}

class SetDesktopState extends NewStates {}
