import 'dart:convert';
import 'dart:math';

import 'package:lightsonheights/core/models/product_category.dart';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  final String? id;
  final String? name;
  final String? image;
  String? price;
  String? salesPrice;
  final String? description;
  final ProductCategory? category;
  int? quantitySelected;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.salesPrice,
    required this.description,
    required this.category,
    this.quantitySelected = 0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'salesPrice': salesPrice,
      'description': description,
      'category': category?.toMap(),
      'quantitySelected': quantitySelected,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      salesPrice:
          map['salesPrice'] != null ? map['salesPrice'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      category: map['category'] != null
          ? ProductCategory.fromMap(map['category'] as Map<String, dynamic>)
          : null,
      quantitySelected:
          map['quantitySelected'] != null ? map['quantitySelected'] as int : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ProductModel copyWith({
    String? id,
    String? name,
    String? image,
    String? price,
    String? salesPrice,
    String? description,
    ProductCategory? category,
    int? quantitySelected,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      salesPrice: salesPrice ?? this.salesPrice,
      description: description ?? this.description,
      category: category ?? this.category,
      quantitySelected: quantitySelected ?? this.quantitySelected,
    );
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, image: $image, price: $price, salesPrice: $salesPrice, description: $description, category: $category, quantitySelected: $quantitySelected)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.image == image &&
        other.price == price &&
        other.salesPrice == salesPrice &&
        other.description == description &&
        other.category == category &&
        other.quantitySelected == quantitySelected;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        image.hashCode ^
        price.hashCode ^
        salesPrice.hashCode ^
        description.hashCode ^
        category.hashCode ^
        quantitySelected.hashCode;
  }

  static List<ProductModel> getAllFashionProducts() {
    List<ProductModel> products = [];
    for (int i = 0; i < 40; i++) {
      products.add(
        ProductModel(
          id: (i + 1).toString(),
          name: 'Product $i',
          image: 'assets/images/${Random().nextInt(10)}.jpg',
          price: Random().nextInt(10000).toString(),
          salesPrice: Random().nextInt(10000).toString(),
          description: 'This is a description of the product $i',
          category: ProductCategory.getProductCategories().elementAt(
              Random().nextInt(ProductCategory.getProductCategories().length)),
        ),
      );
    }
    return products;
  }
}
