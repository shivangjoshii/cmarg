class CollegeModel {
  final String id;
  final String name;
  final String location;
  final String type;
  final String rating;
  final String reviewsCount;
  final String fee;
  final String established;
  final String approvedBy;
  final String imageUrl;
  final String bannerUrl;
  final String description;
  final List<String> highlights;
  final List<String> coursesOffered;

  CollegeModel({
    required this.id,
    required this.name,
    required this.location,
    required this.type,
    required this.rating,
    required this.reviewsCount,
    required this.fee,
    required this.established,
    required this.approvedBy,
    required this.imageUrl,
    required this.bannerUrl,
    required this.description,
    required this.highlights,
    required this.coursesOffered,
  });
}