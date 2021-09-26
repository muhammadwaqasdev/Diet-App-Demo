import 'package:carousel_slider/carousel_slider.dart';
import 'package:diet_app/generated/images.asset.dart';
import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/shared/app_elevated_button.dart';
import 'package:diet_app/src/shared/dashboard_app_bar.dart';
import 'package:diet_app/src/shared/drawer_container.dart';
import 'package:diet_app/src/shared/page_end_spacer.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:diet_app/src/views/dashboard/widgets/dashboard_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'get_started_view_model.dart';

class GetStartedView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<GetStartedView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GetStartedViewModel>.reactive(
      builder: (viewModelContext, model, child) => DrawerContainer(
        controller: model.drawerContainerController,
        drawer: DashboardDrawer(
          onDrawerCloseTap: model.drawerContainerController.toggleDrawer,
        ),
        body: Scaffold(
          appBar: DashboardAppBar(
              onDrawerIconTap: () =>
                  model.drawerContainerController.toggleDrawer()),
          body: Center(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VerticalSpacing(20),
                  SizedBox(
                    width: context.screenSize().width.percent(90),
                    child: CarouselSlider(
                      carouselController: model.buttonCarouselController,
                      options: CarouselOptions(
                          height: context.screenSize().height / 2,
                          viewportFraction: 1,
                          autoPlay: true,
                          onPageChanged: model.onPageChanged),
                      items: model.slides.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Column(
                              children: [
                                Text("Let's get Started",
                                    style: context.textTheme().headline3,
                                    textAlign: TextAlign.center),
                                VerticalSpacing(10),
                                Text("Lorem ipsum dolor sit amet, consetetur",
                                    style: context.textTheme().subtitle2,
                                    textAlign: TextAlign.center),
                                Image.asset(Images.dashboardGetStartedMain),
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
                                onTap: () =>
                                    model.onIndicatorTap(slideIndex - 1),
                                child: AnimatedSize(
                                  vsync: this,
                                  duration: Duration(milliseconds: 250),
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 250),
                                    width: 8 *
                                        (model.currentSlideIndex ==
                                                slideIndex - 1
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
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: AppElevatedButton.withIcon(
                        child: "Setup your Goal",
                        onTap: model.onSetupGoalTap,
                        icon: Image.asset(Images.icRightArrow)),
                  ),
                  PageEndSpacer()
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => GetStartedViewModel(),
    );
  }
}
