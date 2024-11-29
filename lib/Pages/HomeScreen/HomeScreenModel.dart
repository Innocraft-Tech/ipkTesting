import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:zappy/Helpers/AppNavigations/NavigationMixin.dart';
import 'package:zappy/Helpers/Mixins/PopUpMixin.dart';
part 'HomeScreenModel.g.dart';

class HomeScreenModel = _HomeScreenModelBase
    with _$HomeScreenModel, NavigationMixin, PopUpMixin;

abstract class _HomeScreenModelBase with Store {
  @observable
  late LatLng scourceLocation = LatLng(12.8372, 79.7042);
  @action
  void setSourceLocation(LatLng location) {
    scourceLocation = location;
  }

  @observable
  late LatLng destinationLocation = LatLng(0, 0);
  @action
  void setDestinationLocation(LatLng location) {
    destinationLocation = location;
  }

  @observable
  List<LatLng> polypoints = [];
  setPolyPoints(List<LatLng> points) {
    polypoints = points;
  }
}
