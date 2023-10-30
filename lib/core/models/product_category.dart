import 'dart:convert';

class ProductCategory {
  final String? id;
  final String? name;

  ProductCategory({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory ProductCategory.fromMap(Map<String, dynamic> map) {
    return ProductCategory(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCategory.fromJson(String source) =>
      ProductCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  ProductCategory copyWith({
    String? id,
    String? name,
  }) {
    return ProductCategory(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() => 'ProductCategory(id: $id, name: $name)';

  @override
  bool operator ==(covariant ProductCategory other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  static List<ProductCategory> getProductCategories() {
    return [
      ProductCategory(id: '1', name: 'T-Shirts'),
      ProductCategory(id: '2', name: 'Trousers'),
      ProductCategory(id: "3", name: 'Gowns'),
      ProductCategory(id: "4", name: 'Kiki'),
      ProductCategory(id: "6", name: 'tops'),
      ProductCategory(id: "7", name: 'Shirts'),
    ];
  }
}
