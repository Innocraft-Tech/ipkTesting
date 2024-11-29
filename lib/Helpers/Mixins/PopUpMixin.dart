// ignore_for_file: file_names

import 'dart:async';

/* Create an IPopUp abstract class */
abstract class IPopUp {
}

// Create ShowPopUp class to show popup to the user
class ShowPopupWithSingleAction<T> extends IPopUp{
  String popupName;
  String? description;
  String? iconsUrl;
  String buttonText;
  T function;
  ShowPopupWithSingleAction({required this.popupName, this.description, this.iconsUrl, required this.buttonText, required this.function});
}
// Create a mixin PopUpMixin and have a streamcontroller and method to add and dispose events and controller
mixin PopUpMixin {

  // Initailize a streamController to listen the emitted events
  StreamController<IPopUp> popUpController =
      StreamController<IPopUp>();

  /* Create setToastEvent method and add the event into the StreamController variable "popUpController" */
  void setPopupEvent({required IPopUp event}) {
    // Add event inside the stream
    popUpController.add(event);
  }

  /* Create closeToastMixin method to close the popUpController*/
  void closePopupEvent() async {
    
    //  Stop the stream listeneing using close function
    await popUpController.close();
  }
}


class ShowPopupWithMultiAction<T> extends IPopUp{
  String popupName;
  String? description;
  String? iconsUrl;
  List<String> buttonText;
  List<T> function;
  ShowPopupWithMultiAction({required this.popupName, this.description, this.iconsUrl, required this.buttonText, required this.function});
}

