import 'package:mobx/mobx.dart';
import 'package:zappy/Helpers/AppNavigations/NavigationMixin.dart';
import 'package:zappy/Helpers/Mixins/PopUpMixin.dart';
// part 'LoginScreenModel.g.dart';

class LoginScreenModel = LoginScreenModelBase with NavigationMixin, PopUpMixin;

abstract class LoginScreenModelBase with Store {}
