class ProductModel {
  String? q;
  num? from;
  num? to;
  bool? more;
  num? count;
  List<Hit>? hits;

  ProductModel({
    this.q,
    this.from,
    this.to,
    this.more,
    this.count,
    this.hits,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        q: json["q"],
        from: json["from"],
        to: json["to"],
        more: json["more"],
        count: json["count"],
        hits: json["hits"] == null
            ? []
            : List<Hit>.from(json["hits"]!.map((x) => Hit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "q": q,
        "from": from,
        "to": to,
        "more": more,
        "count": count,
        "hits": hits == null
            ? []
            : List<dynamic>.from(hits!.map((x) => x.toJson())),
      };
}

class Hit {
  Recipe? recipe;

  Hit({
    this.recipe,
  });

  factory Hit.fromJson(Map<String, dynamic> json) => Hit(
        recipe: json["recipe"] == null ? null : Recipe.fromJson(json["recipe"]),
      );

  Map<String, dynamic> toJson() => {
        "recipe": recipe?.toJson(),
      };
}

class Recipe {
  String? uri;
  String? label;
  String? image;
  String? source;
  String? url;
  String? shareAs;
  List<MealType>? mealType;

  Recipe({
    this.uri,
    this.label,
    this.image,
    this.source,
    this.url,
    this.shareAs,
    this.mealType,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        uri: json["uri"],
        label: json["label"],
        image: json["image"],
        source: json["source"],
        url: json["url"],
        shareAs: json["shareAs"],
        mealType: json["mealType"] == null
            ? []
            : List<MealType>.from(
                json["mealType"]!.map((x) => mealTypeValues.map[x]!)),
      );

  Map<String, dynamic> toJson() => {
        "uri": uri,
        "label": label,
        "image": image,
        "source": source,
        "url": url,
        "shareAs": shareAs,
        "mealType": mealType == null
            ? []
            : List<dynamic>.from(
                mealType!.map((x) => mealTypeValues.reverse[x])),
      };
}

enum MealType { BRUNCH, LUNCH_DINNER, SNACK }

final mealTypeValues = EnumValues({
  "brunch": MealType.BRUNCH,
  "lunch/dinner": MealType.LUNCH_DINNER,
  "snack": MealType.SNACK
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
