import 'dart:convert';

class Product {
  final int id;
  final String name;
  final num price;
  final List<String> images;
  final bool isOnSale;
  final num? salePercentage;
  final num? salePrice;
  final num regularPrice;
  final String desc;
  final bool isFav;

  Product({
    required this.name,
    required this.price,
    required this.isOnSale,
    required this.regularPrice,
    this.salePercentage,
    this.salePrice,
    this.images = const [],
    required this.id,
    this.desc = '',
    this.isFav = false,
  });

  Product copyWith({
    int? id,
    String? name,
    String? desc,
    num? price,
    List<String>? images,
    bool? isOnSale,
    num? salePercentage,
    num? salePrice,
    num? regularPrice,
    bool? isFav,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      images: images ?? this.images,
      isOnSale: isOnSale ?? this.isOnSale,
      salePercentage: salePercentage ?? this.salePercentage,
      salePrice: salePrice ?? this.salePrice,
      regularPrice: regularPrice ?? this.regularPrice,
      desc: desc ?? this.desc,
      isFav: isFav ?? this.isFav,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'image': images.first,
      'is_on_sale': isOnSale,
      if (salePercentage != null) 'percentage': salePercentage,
      if (salePrice != null) 'sale_price': salePrice,
      'regularPrice': regularPrice,
      'desc': desc,
      'wishlist' : isFav,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] ?? '',
      desc: map['description'] ?? '',
      price: num.tryParse(map['price'].toString()) ?? 0,
      images: List<String>.from([map['image'].toString()]),
      isOnSale: map['is_on_sale'] ?? false,
      salePercentage: num.tryParse(map['percentage'].toString()),
      salePrice: num.tryParse(map['sale_price'].toString()),
      regularPrice: num.tryParse(map['regular_price'].toString()) ?? 0,
      isFav: map['wishlist'] ?? false,
    );
  }

  // double? get getTotalRating {
  //   const num initval = 0;

  //   return (ratings != null
  //           ? ratings!.fold(
  //               initval,
  //               (previousValue, element) =>
  //                   element.rating + double.parse(previousValue.toString()))
  //           : 0) /
  //       (ratings != null && ratings!.isNotEmpty ? ratings!.length : 1);
  // }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(name: $name, price: $price)';
  }
}
