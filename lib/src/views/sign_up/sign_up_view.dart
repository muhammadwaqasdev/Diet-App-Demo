import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_starter_app/generated/images.asset.dart';
import 'package:flutter_starter_app/src/shared/app_bar_action_button.dart';
import 'package:flutter_starter_app/src/shared/app_elevated_button.dart';
import 'package:flutter_starter_app/src/shared/app_textfield.dart';
import 'package:flutter_starter_app/src/shared/empty_app_bar.dart';
import 'package:flutter_starter_app/src/base/utils/utils.dart';
import 'package:flutter_starter_app/src/shared/spacing.dart';
import 'package:flutter_starter_app/src/styles/app_colors.dart';
import 'package:stacked/stacked.dart';

import 'sign_up_view_model.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        appBar: EmptyAppBar(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpacing(10),
                AppBarActionButton(),
                Center(
                  child: Column(
                    children: [
                      Text("Sign Up",
                          style: context.textTheme().headline2,
                          textAlign: TextAlign.center),
                      Text("Login to continue app",
                          style: context.textTheme().subtitle2,
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
                VerticalSpacing(50),
                AppTextField(
                  controller: model.emailTextFieldController,
                  label: "Email Address",
                  // prefixIcon: Text("@",
                  //     style: context
                  //         .textTheme()
                  //         .headline4
                  //         ?.copyWith(color: AppColors.primary)),
                  hint: "Jhondoe@gmail.com",
                  defaultValidators: [
                    DefaultValidators.REQUIRED,
                    DefaultValidators.VALID_EMAIL,
                  ],
                ),
                VerticalSpacing(25),
                AppTextField(
                  controller: model.passwordTextFieldController,
                  label: "Password",
                  defaultValidators: [
                    DefaultValidators.REQUIRED,
                    DefaultValidators.VALID_PASSWORD,
                  ],
                ),
                VerticalSpacing(25),
                AppTextField(
                  controller: model.dobTextFieldController,
                  label: "Date of birth",
                  defaultValidators: [DefaultValidators.REQUIRED],
                ),
                VerticalSpacing(25),
                AppTextField(
                  controller: model.genderTextFieldController,
                  label: "Gender",
                  defaultValidators: [DefaultValidators.REQUIRED],
                ),
                VerticalSpacing(35),
                AppElevatedButton.withIcon(
                    child: "CONTINUE",
                    onTap: model.onContinue,
                    icon: Image.asset(Images.icRightArrow)),
                Spacer(),
                GestureDetector(
                  onTap: model.onSignInTap,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(Platform.isIOS ? 10 : 20),
                      child: Text.rich(
                        TextSpan(
                          style: context.textTheme().headline5?.copyWith(
                                color: AppColors.primary,
                              ),
                          children: [
                            TextSpan(
                              text: 'Already have an account ?',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: ' Sign in',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SignUpViewModel(),
    );
  }
}
