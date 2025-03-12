class Products {
  final String name;
  final String imageUrl;

  Products({required this.name, required this.imageUrl});

  // Ensure that this fromJson factory constructor exists inside your Product class
  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      name: json['title'], // assuming 'title' is the key from your JSON
      imageUrl: json['image'], // assuming 'image' is the key from your JSON
    );
  }
}

class ImagesData {
  final String originalname;
  final String filename;
  final String location;

  ImagesData({
    required this.originalname,
    required this.filename,
    required this.location,
  });

  factory ImagesData.fromJson(Map<String, dynamic> json) {
    return ImagesData(
      originalname:
          json['originalname'], // assuming 'title' is the key from your JSON
      filename: json['filename'],
      location: json['location'], // assuming 'image' is the key from your JSON
    );
  }
}
