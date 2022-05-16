import 'package:diet_app/generated/images.asset.dart';
import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/models/video.dart';
import 'package:diet_app/src/shared/app_bar_action_button.dart';
import 'package:diet_app/src/shared/app_elevated_button.dart';
import 'package:diet_app/src/shared/app_textfield.dart';
import 'package:diet_app/src/shared/empty_app_bar.dart';
import 'package:diet_app/src/shared/load_image.dart';
import 'package:diet_app/src/shared/loading_indicator.dart';
import 'package:diet_app/src/shared/page_end_spacer.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'profile_view_model.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: ViewModelBuilder<ProfileViewModel>.reactive(
        builder: (viewModelContext, model, child) => Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: EmptyAppBar(color: AppColors.semiWhite),
          body: ListView(
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
                          Text("Profile",
                              style: context.textTheme().headline2,
                              textAlign: TextAlign.center),
                          Text("Update your profile here!",
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
                      readOnly: true,
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
                        onTap: () => model.onContinue(viewModelContext),
                        icon: Image.asset(Images.icRightArrow)),
                  ),
                  SizedBox(width: 25, height: 1),
                ],
              ),
              PageEndSpacer()
            ],
          ),
        ),
        viewModelBuilder: () => ProfileViewModel(),
        onModelReady: (model) => model.init(context, Screen.PROFILE),
      ),
    );
  }
}
