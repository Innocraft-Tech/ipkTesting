import 'package:zappy/Helpers/AppNavigations/NavigationConfig.dart';
import 'package:zappy/Helpers/AppNavigations/NavigationMixin.dart';
import 'package:zappy/Helpers/Utilities/Utilities.dart';
import 'package:zappy/Pages/SplashScreen/SplashScreenModel.dart';

class LoginScreenVM extends SplashScreenModel {
  void navigateOTPScreen(String mobileNumber) {
    print(mobileNumber);
    try {
      addNavigationToStream(
          navigate: NavigatorPush(
              pageConfig: Pages.otpScreenConfig, data: mobileNumber));
    } catch (error) {
      error.logExceptionData();
    }
  }
}
