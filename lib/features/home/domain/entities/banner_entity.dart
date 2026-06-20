/// Banner entity.
class BannerEntity {
  final String id;
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final String? actionUrl;

  const BannerEntity({
    required this.id,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.actionUrl,
  });
}
