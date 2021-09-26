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
  int per = 0;
  int calories = 0;
  double fat = 0;
  double carbs = 0;
  double protein = 0;

  Food(
      {this.foodDescription,
      this.foodId,
      this.foodName,
      this.foodType,
      this.foodUrl,
      this.per = 0,
      this.calories = 0,
      this.fat = 0,
      this.carbs = 0,
      this.protein = 0});

  Food.fromJson(Map<String, dynamic> json) {
    double per = 0;
    try {
      per = double.parse("${json['per']}");
    } catch (e) {
      try {
        per = int.parse("${json['per']}") + 0.0;
      } catch (e) {
        String perStr = json['per'];
        if (perStr.contains("/")) {
          json['food_name'] += " " + json['per'];
          per = int.parse(perStr.split("/").first) /
              int.parse(perStr.split("/").last);
        }
      }
    }

    foodDescription = json['food_description'];
    foodId = json['food_id'];
    foodName = json['food_name'];
    foodType = json['food_type'];
    foodUrl = json['food_url'];
    per = per;
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
    data['per'] = this.per;
    data['calories'] = this.calories;
    data['fat'] = this.fat;
    data['carbs'] = this.carbs;
    data['protein'] = this.protein;
    return data;
  }

  @override
  bool operator ==(Object other) => other is Food && other.foodId == foodId;

  @override
  int get hashCode => foodId.hashCode;
}
