import 'package:zappy/Helpers/AppNavigations/NavigationConfig.dart';
import 'package:zappy/Helpers/AppNavigations/NavigationMixin.dart';
import 'package:zappy/Helpers/Utilities/Utilities.dart';
import 'package:zappy/Pages/SplashScreen/SplashScreenModel.dart';

class SplashScreenVM extends SplashScreenModel {
  void navigateToLoginScreen() {
    try {
      addNavigationToStream(
          navigate: NavigatorPushReplace(
              pageConfig: Pages.loginScreenConfig, data: ""));
    } catch (error) {
      error.logExceptionData();
    }
  }
}
