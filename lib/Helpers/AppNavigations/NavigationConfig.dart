import 'package:zappy/Pages/HomeScreen/HomeScreen.dart';
import 'package:zappy/Pages/LocationSearchScreen/DependentViews/LocationSearchBar.dart';
import 'package:zappy/Pages/LocationSearchScreen/LocationSearchScreen.dart';
import 'package:zappy/Pages/OTPScreen/OTPScreen.dart';
import 'package:zappy/Pages/LoginScreen/LoginScreen.dart';
import 'package:zappy/Pages/SplashScreen/SplashScreen.dart';

import 'NavigationHelpers.dart';

enum Routes {
  SplashScreen,
  Loginscreen,
  OTPScreen,
  HomeScreen,
  LocationSearchScreen
}

class Pages {
  //! Data for Bottom Nav Config
  Object? data;

  //! Screen Config
  static final PageConfig splashScreenConfig = PageConfig(
    route: Routes.SplashScreen,
    build: (_) => SplashScreen(),
  );
  static final PageConfig loginScreenConfig = PageConfig(
    route: Routes.Loginscreen,
    build: (_) => LoginScreen(),
  );
  static final PageConfig otpScreenConfig = PageConfig(
    route: Routes.OTPScreen,
    build: (_) => OTPScreen(
      mobileNumber: otpScreenConfig.data,
    ),
  );

  static final PageConfig homeScreenConfig = PageConfig(
    route: Routes.HomeScreen,
    build: (_) => HomeScreen(),
  );

  static final PageConfig locationSearchScreenConfig = PageConfig(
    route: Routes.LocationSearchScreen,
    build: (_) => LocationSearchScreen(
      locations: locationSearchScreenConfig.data,
    ),
  );
}
