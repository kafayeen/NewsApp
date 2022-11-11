abstract class NewStates {}

class IniailNewStates extends NewStates {}

class bottomChangeNewStates extends NewStates {}

class businessDataNewStates extends NewStates {}

class loadingbusinessDataNewStates extends NewStates {}

class businessErrorNewStates extends NewStates {
  final String? error;
  businessErrorNewStates({required this.error});
}

class sportsDataNewStates extends NewStates {}

class sportsErrorNewStates extends NewStates {
  final String? error;
  sportsErrorNewStates({required this.error});
}

class searchDataNewStates extends NewStates {}

class searchErrorNewStates extends NewStates {
  final String? error;
  searchErrorNewStates({required this.error});
}

class scienceDataNewStates extends NewStates {}

class scienceErrorNewStates extends NewStates {
  final String? error;
  scienceErrorNewStates({required this.error});
}

class toogleModeState extends NewStates {}

class ChangeDetectItemState extends NewStates {}

class SetDesktopState extends NewStates {}
