import 'package:zappy/Helpers/AppNavigations/NavigationMixin.dart';
import 'package:zappy/Helpers/Utilities/Utilities.dart';
import 'package:zappy/Pages/LocationSearchScreen/LocationSearchScreenModel.dart';

class LocationSearchScreenVM extends LocationSearchScreenModel {
  void navigateToHomeScreen() {
    try {
      addNavigationToStream(navigate: NavigatorPop());
    } catch (error) {
      error.logExceptionData();
    }
  }
}
