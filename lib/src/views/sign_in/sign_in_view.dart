import 'dart:io';

import 'package:diet_app/generated/images.asset.dart';
import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/shared/app_bar_action_button.dart';
import 'package:diet_app/src/shared/app_elevated_button.dart';
import 'package:diet_app/src/shared/app_textfield.dart';
import 'package:diet_app/src/shared/empty_app_bar.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'sign_in_view_model.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: EmptyAppBar(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      VerticalSpacing(10),
                      Row(
                        children: [
                          AppBarActionButton(),
                        ],
                      ),
                      Center(
                        child: Column(
                          children: [
                            Text("Sign In",
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
                      VerticalSpacing(35),
                      AppElevatedButton.withIcon(
                          isLoading: model.isBusy,
                          child: "CONTINUE",
                          onTap: () => model.onContinue(context),
                          icon: Image.asset(Images.icRightArrow)),
                    ],
                  ),
                ),
                if (!model.isKeyboardVisible)
                  GestureDetector(
                    onTap: model.onSignUpTap,
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
                                text: 'Need an account ?',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: ' Sign up',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
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
      viewModelBuilder: () => SignInViewModel(),
    );
  }
}
