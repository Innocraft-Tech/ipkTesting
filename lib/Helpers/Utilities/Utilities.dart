// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'dart:io';

extension ExceptionalHandling on Object {
  void logExceptionData() {
    try {
      // print the catched exception
      debugPrint("* --_-- Exception --_-- *");

      debugPrint(this.toString());

      debugPrint("* --_-- --_-- *");
    } catch (error) {
      debugPrint("* --_-- Exception --_-- *");

      // prints the exception caught while printing the exception
      debugPrint(error.toString());

      debugPrint("* --_-- --_-- *");
    }
  }
}

extension StringExtension on String {
  String pascalCase() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

/// Creates an instance of the [PlatformWrapper] class to provide access to platform-specific functionalities.
///
/// Example usage:
/// ```dart
/// PlatformWrapper platformWrapper = PlatformWrapper();
/// bool isWindows = platformWrapper.isWindows;
/// print('Is Windows? $isWindows');
/// ```
class PlatformWrapper {
  /// Returns a boolean value indicating whether the current platform is Windows.
  ///
  /// Returns `true` if the current platform is Windows, and `false` otherwise.
  bool get isWindows => Platform.isWindows;
}
