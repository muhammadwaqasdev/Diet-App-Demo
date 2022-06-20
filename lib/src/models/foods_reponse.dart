import 'package:diet_app/src/models/goal.dart';

class FoodsResponse {
  Foods? foods;

  FoodsResponse({this.foods});

  FoodsResponse.fromJson(Map<String, dynamic> json) {
    foods = json['foods'] != null ? new Foods.fromJson(json['foods']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.foods != null) {
      data['foods'] = this.foods?.toJson();
    }
    return data;
  }
}

class Foods {
  List<Food>? food;
  String? maxResults;
  String? pageNumber;
  String? totalResults;

  Foods({this.food, this.maxResults, this.pageNumber, this.totalResults});

  Foods.fromJson(Map<String, dynamic> json) {
    if (json['food'] != null) {
      food = [];
      json['food'].forEach((v) {
        food?.add(new Food.fromJson(v));
      });
    }
    maxResults = json['max_results'];
    pageNumber = json['page_number'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.food != null) {
      data['food'] = this.food?.map((v) => v.toJson()).toList();
    }
    data['max_results'] = this.maxResults;
    data['page_number'] = this.pageNumber;
    data['total_results'] = this.totalResults;
    return data;
  }
}

class Food {
  String? foodDescription;
  String? foodId;
  String? foodName;
  String? foodType;
  String? foodUrl;
  String? servingUnit;
  String? per;
  int calories = 0;
  double fat = 0;
  double carbs = 0;
  double protein = 0;
  Macros? macro;

  Food(
      {this.foodDescription,
      this.foodId,
      this.foodName,
      this.foodType,
      this.foodUrl,
      this.servingUnit,
      this.per,
      this.calories = 0,
      this.fat = 0,
      this.carbs = 0,
      this.protein = 0,
      this.macro});

  double getMacro(Macros macro) {
    switch (macro) {
      case Macros.Carbs:
        return this.carbs;
      case Macros.Protein:
        return this.protein;
      case Macros.Fat:
        return this.fat;
    }
  }

  Food.fromJson(Map<String, dynamic> json) {
    // double per = 0;
    // try {
    //   per = double.parse("${json['per']}");
    // } catch (e) {
    //   try {
    //     per = int.parse("${json['per']}") + 0.0;
    //   } catch (e) {
    //     String perStr = json['per'];
    //     if (perStr.contains("/")) {
    //       json['food_name'] += " " + json['per'];
    //       per = int.parse(perStr.split("/").first) /
    //           int.parse(perStr.split("/").last);
    //     }
    //   }
    // }

    foodDescription = json['food_description'];
    foodId = json['food_id'];
    foodName = json['food_name'];
    foodType = json['food_type'];
    foodUrl = json['food_url'];
    servingUnit = json['serving_unit'];
    this.per = json['per'].toString();
    calories = int.parse("${json['calories']}");
    fat = double.parse("${json['fat']}");
    carbs = double.parse("${json['carbs']}");
    protein = double.parse("${json['protein']}");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['food_description'] = this.foodDescription;
    data['food_id'] = this.foodId;
    data['food_name'] = this.foodName;
    data['food_type'] = this.foodType;
    data['food_url'] = this.foodUrl;
    data['serving_unit'] = this.servingUnit;
    data['per'] = this.per;
    data['calories'] = this.calories;
    data['fat'] = this.fat;
    data['carbs'] = this.carbs;
    data['protein'] = this.protein;
    return data;
  }

  Food copyWith(
      {String? foodDescription,
      String? foodId,
      String? foodName,
      String? foodType,
      String? foodUrl,
      String? servingUnit,
      String? per,
      int? calories,
      double? fat,
      double? carbs,
      double? protein,
      Macros? macro}) {
    return Food(
        foodDescription: foodDescription ?? this.foodDescription,
        foodId: foodId ?? this.foodId,
        foodName: foodName ?? this.foodName,
        foodType: foodType ?? this.foodType,
        foodUrl: foodUrl ?? this.foodUrl,
        servingUnit: servingUnit ?? this.servingUnit,
        per: per ?? this.per,
        calories: calories ?? this.calories,
        fat: fat ?? this.fat,
        carbs: carbs ?? this.carbs,
        protein: protein ?? this.protein,
        macro: macro ?? this.macro);
  }

  @override
  bool operator ==(Object other) => other is Food && other.foodId == foodId;

  @override
  int get hashCode => foodId.hashCode;
}
