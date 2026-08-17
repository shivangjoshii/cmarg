class SubscriptionPlanModel {
  final String id;
  final String title;
  final String tag;
  final String originalPrice;
  final int price;
  final String discountPercentage;
  final bool isMostPopular;
  final String category; 
  final List<String> features;

  SubscriptionPlanModel({
    required this.id,
    required this.title,
    required this.tag,
    required this.originalPrice,
    required this.price,
    required this.discountPercentage,
    required this.isMostPopular,
    required this.category,
    required this.features,
  });
}