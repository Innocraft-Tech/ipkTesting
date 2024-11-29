import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zappy/Helpers/AppConstants/AppConstants.dart';
import 'package:zappy/Helpers/AppNavigations/NavigationHelpers.dart';
import 'package:zappy/Helpers/AppNavigations/NavigationMixin.dart';
import 'package:zappy/Helpers/Resources/Styles/Styles.dart';
import 'package:zappy/Helpers/ResponsiveUI.dart';
import 'package:zappy/Pages/LoginScreen/LoginScreenVM.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginScreenVM _loginScreenVM = LoginScreenVM();
  TextEditingController _phoneNumberController = TextEditingController();
  FocusNode _phoneNumberFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginScreenVM.navigationStream.stream.listen((event) {
      if (event is NavigatorPush) {
        context.push(pageConfig: event.pageConfig, data: event.data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Styles.secondaryColor,
      body: Padding(
        padding: EdgeInsets.only(
            top: ResponsiveUI.h(69, context),
            bottom: ResponsiveUI.h(411, context),
            left: ResponsiveUI.w(16, context),
            right: ResponsiveUI.w(16, context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: ResponsiveUI.w(314, context)),
              child: SizedBox(
                width: ResponsiveUI.w(60, context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      AppConstants.helpIcon,
                      width: ResponsiveUI.w(24, context),
                      height: ResponsiveUI.h(24, context),
                    ),
                    Text(
                      "Help",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: ResponsiveUI.sp(14, context),
                        fontWeight: FontWeight.w400,
                        color: Styles.backgroundPrimary,
                        height: 17 / 14,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SvgPicture.asset(
              AppConstants.appLogo,
              width: ResponsiveUI.w(139, context),
              height: ResponsiveUI.h(59, context),
            ),
            TextFormField(
              controller: _phoneNumberController,
              focusNode: _phoneNumberFocusNode,
              onTapOutside: (event) => _phoneNumberFocusNode.unfocus(),
              style: TextStyle(
                color: Styles.backgroundPrimary,
                fontFamily: "MontserratRegular",
                fontSize: ResponsiveUI.sp(14, context),
                fontWeight: FontWeight.w400,
                height: 17 / 14,
              ),
              // onChanged: (value) {
              //   _phoneNumberController.text = value;
              // },
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUI.w(12, context),
                  ),
                  child: Text(
                    "+91",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: ResponsiveUI.sp(14, context),
                      fontWeight: FontWeight.w400,
                      color: Styles.textPrimary,
                      height: 17 / 14,
                    ),
                  ),
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth:
                      ResponsiveUI.w(30, context), // Adjust size as needed
                ),
                hintText: "Enter your phone number",
                hintStyle: TextStyle(
                  fontFamily: "MontserratRegular",
                  fontSize: ResponsiveUI.sp(14, context),
                  fontWeight: FontWeight.w400,
                  color: Styles.textSecondary,
                  height: 17 / 14,
                ),
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
            SizedBox(
              width: ResponsiveUI.w(251, context),
              child: Text(
                "By continuing, you agree to our Terms of Service & Privacy Policy",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "MontserratRegular",
                  fontSize: ResponsiveUI.sp(14, context),
                  fontWeight: FontWeight.w400,
                  color: Styles.backgroundPrimary,
                  height: 20 / 14,
                ),
              ),
            ),
            SizedBox(
              width: ResponsiveUI.w(370, context), // Custom width
              height: ResponsiveUI.h(48, context), // Custom height
              child: FilledButton(
                onPressed: () {
                  print(_phoneNumberController.text);
                  _loginScreenVM.navigateOTPScreen(_phoneNumberController.text);
                },
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(ResponsiveUI.r(10, context)))),
                  backgroundColor: WidgetStatePropertyAll(Styles
                      .primaryColor), // Fixed typo: WidgetStatePropertyAll -> MaterialStatePropertyAll
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: ResponsiveUI.sp(14, context),
                    fontWeight: FontWeight.w400,
                    color: Styles.backgroundPrimary,
                    height: 17 / 14,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
