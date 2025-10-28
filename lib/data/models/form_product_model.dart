class FormProductModel {
  final String name;
  final String year;
  final String price;
  final String cpu;
  final String disk;

  const FormProductModel({
    this.name = '',
    this.year = '',
    this.price = '',
    this.cpu = '',
    this.disk = '',
  });

  FormProductModel copyWith({
    String? name,
    String? year,
    String? price,
    String? cpu,
    String? disk,
  }) {
    return FormProductModel(
      name: name ?? this.name,
      year: year ?? this.year,
      price: price ?? this.price,
      cpu: cpu ?? this.cpu,
      disk: disk ?? this.disk,
    );
  }

  bool get isValid =>
      name.isNotEmpty &&
      int.tryParse(year) != null &&
      double.tryParse(price) != null &&
      double.tryParse(price)! > 0;
}
