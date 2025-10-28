class Product {
  final int id;
  final String name;
  final Map<String, dynamic>? data;

  Product({required this.id, required this.name, this.data});

  factory Product.fromJson(Map<String, dynamic> json) {
    final rawId = json['id'];
    return Product(
      id: int.tryParse(rawId.toString()) ?? 0,
      name: json['name'] ?? '',
      data: json['data'] is Map<String, dynamic> ? json['data'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "data": data};
  }
}
