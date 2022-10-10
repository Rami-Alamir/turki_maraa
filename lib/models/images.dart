class Images {
  String? imageUrl;

  Images({
    this.imageUrl,
  });

  Images.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
  }
}
