import 'package:diet_app/generated/images.asset.dart';
import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/models/video.dart';
import 'package:diet_app/src/shared/app_bar_action_button.dart';
import 'package:diet_app/src/shared/app_elevated_button.dart';
import 'package:diet_app/src/shared/app_textfield.dart';
import 'package:diet_app/src/shared/empty_app_bar.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:diet_app/src/views/settings/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: ViewModelBuilder<SettingsViewModel>.reactive(
        builder: (viewModelContext, model, child) => Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            appBar: EmptyAppBar(color: AppColors.semiWhite),
            body: ListView(children: [
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
                              Text("Settings",
                                  style: context.textTheme().headline2,
                                  textAlign: TextAlign.center),
                              Text("Update your password here!",
                                  style: context.textTheme().subtitle2,
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                        VerticalSpacing(25),
                        AppTextField(
                          controller: model.passwordTextFieldController,
                          label: "Current Password",
                          placeholder: "Password with atleast 6 characters",
                          defaultValidators: [
                            DefaultValidators.REQUIRED,
                            DefaultValidators.VALID_PASSWORD,
                          ],
                        ),
                        VerticalSpacing(25),
                        AppTextField(
                          controller: model.newPasswordTextFieldController,
                          label: "New Password",
                          placeholder: "Password with atleast 6 characters",
                          defaultValidators: [
                            DefaultValidators.REQUIRED,
                            DefaultValidators.VALID_PASSWORD,
                          ],
                        ),
                      ])),
              VerticalSpacing(35),
              Row(
                children: [
                  SizedBox(width: 25, height: 1),
                  Expanded(
                    child: AppElevatedButton.withIcon(
                        isLoading: model.isBusy,
                        child: "UPDATE PASSWORD",
                        onTap: () => model.onContinue(viewModelContext),
                        icon: Image.asset(Images.icRightArrow)),
                  ),
                  SizedBox(width: 25, height: 1),
                ],
              ),
            ])),
        viewModelBuilder: () => SettingsViewModel(),
        onModelReady: (model) => model.init(context, Screen.SETTINGS),
      ),
    );
  }
}
