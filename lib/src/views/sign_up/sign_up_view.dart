import 'dart:io';

import 'package:diet_app/src/shared/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:diet_app/generated/images.asset.dart';
import 'package:diet_app/src/shared/app_bar_action_button.dart';
import 'package:diet_app/src/shared/app_elevated_button.dart';
import 'package:diet_app/src/shared/app_textfield.dart';
import 'package:diet_app/src/shared/empty_app_bar.dart';
import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:stacked/stacked.dart';

import 'sign_up_view_model.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ViewModelBuilder<SignUpViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
          appBar: EmptyAppBar(),
          body: SafeArea(
            child: ListView(
              children: [
                Padding(
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
                            Text("Sign Up to continue app",
                                style: context.textTheme().subtitle2,
                                textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                      VerticalSpacing(25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(95 / 2),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(.51),
                                  offset: Offset(0, 14),
                                  blurRadius: 19,
                                ),
                              ],
                            ),
                            child: LoadImage(
                              model.user.displayImageUrl ?? '',
                              size: Size(95, 95),
                              isCircle: true,
                              pickedImage: model.uploadImage,
                              isUploadLoader: model.isBusy,
                              hasPickOption: true,
                            ),
                          )
                        ],
                      ),
                      VerticalSpacing(25),
                      AppTextField(
                        controller: model.fullNameTextFieldController,
                        label: "Full Name",
                        hint: "Your full name",
                        defaultValidators: [DefaultValidators.REQUIRED],
                      ),
                      VerticalSpacing(25),
                      AppTextField(
                        controller: model.emailTextFieldController,
                        label: "Email Address",
                        // prefixIcon: Text("@",
                        //     style: context
                        //         .textTheme()
                        //         .headline4
                        //         ?.copyWith(color: AppColors.primary)),
                        placeholder: "Your email address",
                        defaultValidators: [
                          DefaultValidators.REQUIRED,
                          DefaultValidators.VALID_EMAIL,
                        ],
                      ),
                      VerticalSpacing(25),
                      AppTextField(
                        controller: model.passwordTextFieldController,
                        label: "Password",
                        placeholder: "Password with atleast 6 characters",
                        defaultValidators: [
                          DefaultValidators.REQUIRED,
                          DefaultValidators.VALID_PASSWORD,
                        ],
                      ),
                      VerticalSpacing(25),
                      GestureDetector(
                        onTap: () => model.openDatePicker(context),
                        child: AppTextField(
                          readOnly: true,
                          readonlyEffect: false,
                          controller: model.dobTextFieldController,
                          label: "Date of birth",
                          placeholder: "dd / mm / yyyy",
                          defaultValidators: [DefaultValidators.REQUIRED],
                        ),
                      ),
                      VerticalSpacing(25),
                      PopupMenuButton(
                        onSelected: model.onGenderSelected,
                        itemBuilder: (ctx) => model.genders
                            .map((gender) => PopupMenuItem(
                                  child: Text(gender,
                                      style: context
                                          .textTheme()
                                          .subtitle2
                                          ?.copyWith(
                                              fontWeight: FontWeight.w300)),
                                  value: model.genders.indexOf(gender),
                                ))
                            .toList(),
                        child: AppTextField(
                          readOnly: true,
                          readonlyEffect: false,
                          controller: model.genderTextFieldController,
                          label: "Gender",
                          defaultValidators: [DefaultValidators.REQUIRED],
                        ),
                      ),
                      VerticalSpacing(35),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: 25, height: 1),
                    Expanded(
                      child: AppElevatedButton.withIcon(
                          isLoading: model.isBusy,
                          child: "CONTINUE",
                          onTap: () => model.onContinue(context),
                          icon: Image.asset(Images.icRightArrow)),
                    ),
                    SizedBox(width: 25, height: 1),
                  ],
                ),
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
        viewModelBuilder: () => SignUpViewModel(),
      ),
    );
  }
}
