import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zappy/Helpers/AppConstants/AppConstants.dart';
import 'package:zappy/Helpers/Resources/Styles/Styles.dart';
import 'package:zappy/Helpers/ResponsiveUI.dart';
import 'dart:async'; // For the Timer class

class OTPScreen extends StatefulWidget {
  late String mobileNumber;
  OTPScreen({super.key, required this.mobileNumber});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  int _timerValue = 0;
  Timer? _timer;
  String mobileNum = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mobileNum = widget.mobileNumber;
  }

  @override
  void dispose() {
    // Dispose controllers, focus nodes, and cancel the timer
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _timer?.cancel(); // Cancel the timer if it's running
    super.dispose();
  }

  void _onOtpFieldChanged(String value, int index) {
    if (value.isNotEmpty) {
      // Move to the next field
      if (index < _focusNodes.length - 1) {
        _focusNodes[index + 1].requestFocus();
      }
    } else {
      // If the field is cleared, move focus to the previous field
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  // Function to start the countdown timer
  void _startTimer() {
    setState(() {
      _timerValue = 30; // Reset timer to 30 seconds
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timerValue > 0) {
        setState(() {
          _timerValue--;
        });
      } else {
        timer.cancel(); // Stop the timer when it reaches 0
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.secondaryColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUI.w(16, context),
            vertical: ResponsiveUI.h(20, context),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: ResponsiveUI.h(50, context)),
              SvgPicture.asset(
                AppConstants.appLogo,
                width: ResponsiveUI.w(139, context),
                height: ResponsiveUI.h(59, context),
              ),
              SizedBox(height: ResponsiveUI.h(20, context)),
              Text(
                "Verify Details",
                style: TextStyle(
                  fontFamily: "MontserratMedium",
                  fontSize: ResponsiveUI.sp(16, context),
                  fontWeight: FontWeight.w500,
                  color: Styles.backgroundPrimary,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ResponsiveUI.h(10, context)),
              Text(
                "OTP sent to (+91 ${mobileNum})",
                style: TextStyle(
                  color: const Color(0xFFB9B9B9),
                  fontSize: ResponsiveUI.sp(14, context),
                  fontFamily: 'Montserrat',
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ResponsiveUI.h(20, context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => SizedBox(
                    width: ResponsiveUI.w(60, context),
                    child: TextFormField(
                      style: TextStyle(
                        color: Styles.backgroundPrimary,
                        fontFamily: "MontserratRegular",
                        fontSize: ResponsiveUI.sp(14, context),
                        fontWeight: FontWeight.w400,
                        height: 17 / 14,
                      ),
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      onTapOutside: (event) => _focusNodes[index].unfocus(),
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _onOtpFieldChanged(value, index),
                      decoration: InputDecoration(
                        counterText: "", // Hides the character count
                        contentPadding: EdgeInsets.symmetric(
                          vertical: ResponsiveUI.h(15, context),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Styles.backgroundPrimary,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Styles.backgroundPrimary,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(
                            ResponsiveUI.r(10, context),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: ResponsiveUI.h(30, context)),
              SizedBox(
                width: ResponsiveUI.w(370, context),
                height: ResponsiveUI.h(48, context),
                child: ElevatedButton(
                  onPressed: () {
                    // Combine the OTP values
                    String otp = _otpControllers
                        .map((controller) => controller.text)
                        .join();
                    print("Entered OTP: $otp");
                  },
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          ResponsiveUI.r(10, context),
                        ),
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                      Styles.primaryColor,
                    ),
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: ResponsiveUI.sp(14, context),
                      fontWeight: FontWeight.w400,
                      color: Styles.backgroundPrimary,
                      height: 1.3,
                    ),
                  ),
                ),
              ),
              SizedBox(height: ResponsiveUI.h(18, context)),
              GestureDetector(
                onTap: () {
                  print("object");
                  if (_timerValue == 0) {
                    _startTimer(); // Start timer if it's 0
                  }
                },
                child: Text(
                  _timerValue == 0
                      ? "Resend OTP"
                      : "Resend OTP ($_timerValue)", // Show countdown
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: ResponsiveUI.sp(14, context),
                    fontWeight: FontWeight.w500,
                    color: Styles.primaryColor,
                    height: 18 / 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
