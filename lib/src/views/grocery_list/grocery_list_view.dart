import 'package:diet_app/generated/images.asset.dart';
import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/models/foods_reponse.dart';
import 'package:diet_app/src/models/video.dart';
import 'package:diet_app/src/shared/app_bar_action_button.dart';
import 'package:diet_app/src/shared/empty_app_bar.dart';
import 'package:diet_app/src/shared/loading_indicator.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'grocery_list_view_model.dart';

class GroceryListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ViewModelBuilder<GroceryListViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: EmptyAppBar(color: AppColors.semiWhite),
          body: Stack(
            children: [
              Container(
                height: 230,
                color: AppColors.semiWhite.withOpacity(0.5),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      VerticalSpacing(10),
                      AppBarActionButton(),
                      VerticalSpacing(20),
                      Text(
                        "Grocery List",
                        style: context.textTheme().headline3,
                      ),
                      Text(
                        "Your grocery list for a week!",
                        style: context.textTheme().headline5,
                      ),
                      VerticalSpacing(20),
                      if (model.isBusy)
                        Center(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: context.screenSize().height / 3),
                              child: LoadingIndicator()),
                        ),
                      if (!model.isBusy && model.foods.isEmpty) ...[
                        VerticalSpacing(context.screenSize().height / 5),
                        Center(
                          child: Column(
                            children: [
                              Image.asset(Images.emptyFolder, width: 200),
                              Text(
                                "No videos available!",
                                style: context.textTheme().headline5,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        )
                      ],
                      if (!model.isBusy && model.foods.isNotEmpty)
                        ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: model.foods.length,
                          itemBuilder: (_, index) => ((Food food) =>
                                  _groceryListItem(
                                      food, model.weights[food.foodId] ?? 0))(
                              model.foods[index]),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        viewModelBuilder: () => GroceryListViewModel(),
        onModelReady: (model) => model.init(context, Screen.GROCERY_LIST),
      ),
    );
  }

  Widget _groceryListItem(Food food, int qty) => Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          food.foodName!,
                          style: TextStyle(
                            fontSize: 12,
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      HorizontalSpacing(5),
                      Container(
                        child: Text("x $qty",
                            style:
                                TextStyle(fontSize: 10, color: Colors.white)),
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                      )
                    ],
                  ),
                  VerticalSpacing(5),
                  Text(
                    food.foodDescription!,
                    style: TextStyle(
                      fontSize: 10,
                      color: const Color(0xff888888),
                    ),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
            ),
            HorizontalSpacing(25),
            Text(
              '${food.per} ${food.servingUnit}',
              style: TextStyle(
                fontSize: 15,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            )
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(0xffffffff),
          border: Border.all(width: 1.0, color: const Color(0xffebebeb)),
        ),
      );
}
