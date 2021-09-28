import 'package:diet_app/src/models/app_user.dart';
import 'package:stacked/stacked.dart';

class AuthService with ReactiveServiceMixin {
  ReactiveValue<AppUser?> _user = ReactiveValue<AppUser?>(null);

  AppUser? get user => _user.value;

  AuthService() {
    listenToReactiveValues([_user]);
  }

  set user(AppUser? user) {
    _user.value = user;
    notifyListeners();
  }
}
