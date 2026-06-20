/// News entity.
class NewsEntity {
  final String id;
  final String title;
  final String source;
  final DateTime publishedAt;
  final String? imageUrl;
  final String? url;

  const NewsEntity({
    required this.id,
    required this.title,
    required this.source,
    required this.publishedAt,
    this.imageUrl,
    this.url,
  });
}
