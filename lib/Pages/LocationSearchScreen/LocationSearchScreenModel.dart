import 'package:mobx/mobx.dart';
import 'package:zappy/Helpers/AppNavigations/NavigationMixin.dart';
import 'package:zappy/Helpers/Mixins/PopUpMixin.dart';
// part 'LocationSearchScreenModel.g.dart';

class LocationSearchScreenModel = LocationSearchScreenModelBase
    with NavigationMixin, PopUpMixin;

abstract class LocationSearchScreenModelBase with Store {}
