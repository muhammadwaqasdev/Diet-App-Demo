import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_app/generated/images.asset.dart';
import 'package:flutter_starter_app/src/shared/app_elevated_button.dart';
import 'package:flutter_starter_app/src/base/utils/utils.dart';
import 'package:flutter_starter_app/src/shared/empty_app_bar.dart';
import 'package:flutter_starter_app/src/shared/spacing.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_starter_app/src/styles/app_colors.dart';
import 'package:stacked/stacked.dart';
import 'splash_view_model.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      builder: (viewModelContext, model, child) => Scaffold(
        appBar: EmptyAppBar(),
        body: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                SizedBox(
                  width: context.screenSize().width.percent(76),
                  child: CarouselSlider(
                    carouselController: model.buttonCarouselController,
                    options: CarouselOptions(
                        height: context.screenSize().height / 1.950,
                        viewportFraction: 1,
                        autoPlay: true,
                        onPageChanged: model.onPageChanged),
                    items: model.slides.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Column(
                            children: [
                              Image.asset(Images.preLoginMain),
                              VerticalSpacing(35),
                              Text("Lorem ipsum dolor sit",
                                  style: context.textTheme().headline4,
                                  textAlign: TextAlign.center),
                              VerticalSpacing(10),
                              Text(
                                  "Lorem ipsum dolor sit amet, consetetur\nsadipscing elitr, sed diam nonumy",
                                  style: context.textTheme().subtitle2,
                                  textAlign: TextAlign.center),
                            ],
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: model.slides
                        .map((slideIndex) => GestureDetector(
                              onTap: () => model.onIndicatorTap(slideIndex - 1),
                              child: AnimatedSize(
                                vsync: this,
                                duration: Duration(milliseconds: 250),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 250),
                                  width: 8 *
                                      (model.currentSlideIndex == slideIndex - 1
                                          ? 4
                                          : 1),
                                  height: 8,
                                  margin: EdgeInsets.symmetric(horizontal: 6),
                                  decoration: BoxDecoration(
                                      color: model.currentSlideIndex ==
                                              slideIndex - 1
                                          ? AppColors.primary
                                          : AppColors.greyBgDarker,
                                      borderRadius:
                                          BorderRadius.circular(8 / 2)),
                                ),
                              ),
                            ))
                        .toList()),
                VerticalSpacing(50),
                SizedBox(
                  width: context.screenSize().width.percent(74.53),
                  height: 52,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: AppElevatedButton(
                              child: "Sign Up", onTap: model.onSignUpTap)),
                      HorizontalSpacing(22),
                      Expanded(
                          child: AppElevatedButton.flat(
                              child: "Sign In", onTap: model.onSignInTap))
                    ],
                  ),
                ),
                Spacer()
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SplashViewModel(),
    );
  }
}
