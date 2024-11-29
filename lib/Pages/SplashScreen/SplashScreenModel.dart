import 'package:mobx/mobx.dart';
import 'package:zappy/Helpers/AppNavigations/NavigationMixin.dart';
import 'package:zappy/Helpers/Mixins/PopUpMixin.dart';
// part 'SplashScreenModel.g.dart';

class SplashScreenModel = SplashScreenModelBase
    with NavigationMixin, PopUpMixin;

abstract class SplashScreenModelBase with Store {}
