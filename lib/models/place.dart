class Place {
  final String name;
  final String? description;
  final String imageUrl;
  final double? lat;
  final double? lng;
  final String? category;
  final String? country;
  final String? tag; // e.g. "Spring", "Summer", etc.

  Place({
    required this.name,
    required this.imageUrl,
    this.description,
    this.lat,
    this.lng,
    this.category,
    this.country,
    this.tag,
  });
}
