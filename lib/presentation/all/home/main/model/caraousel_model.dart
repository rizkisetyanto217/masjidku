class CarouselModel {
  final String carouselId;
  final String carouselTitle;
  final String carouselCaption;
  final String carouselImageUrl;
  final String carouselTargetUrl;
  final String carouselType;
  final int carouselOrder;
  final bool carouselIsActive;
  final DateTime carouselCreatedAt;
  final DateTime carouselUpdatedAt;

  CarouselModel({
    required this.carouselId,
    required this.carouselTitle,
    required this.carouselCaption,
    required this.carouselImageUrl,
    required this.carouselTargetUrl,
    required this.carouselType,
    required this.carouselOrder,
    required this.carouselIsActive,
    required this.carouselCreatedAt,
    required this.carouselUpdatedAt,
  });

  factory CarouselModel.fromJson(Map<String, dynamic> json) {
    return CarouselModel(
      carouselId: json['carousel_id'],
      carouselTitle: json['carousel_title'],
      carouselCaption: json['carousel_caption'],
      carouselImageUrl: json['carousel_image_url'],
      carouselTargetUrl: json['carousel_target_url'],
      carouselType: json['carousel_type'],
      carouselOrder: json['carousel_order'],
      carouselIsActive: json['carousel_is_active'],
      carouselCreatedAt: DateTime.parse(json['carousel_created_at']),
      carouselUpdatedAt: DateTime.parse(json['carousel_updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carousel_id': carouselId,
      'carousel_title': carouselTitle,
      'carousel_caption': carouselCaption,
      'carousel_image_url': carouselImageUrl,
      'carousel_target_url': carouselTargetUrl,
      'carousel_type': carouselType,
      'carousel_order': carouselOrder,
      'carousel_is_active': carouselIsActive,
      'carousel_created_at': carouselCreatedAt.toIso8601String(),
      'carousel_updated_at': carouselUpdatedAt.toIso8601String(),
    };
  }
}
