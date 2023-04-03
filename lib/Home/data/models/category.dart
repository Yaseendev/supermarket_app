import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:supermarket_app/Product/data/models/product.dart';

class Category extends Equatable{
  final int id;
  final String name;
  final String desc;
  final String imgUrl;
  final List<Product> products;
  
  Category({
    required this.id,
    required this.name,
    required this.desc,
    required this.imgUrl,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'desc': desc,
      'imgUrl': imgUrl,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      name: map['name'] ?? '',
      desc: map['desc'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      products: List<Product>.from(((map['products'] as List<dynamic>?) ?? []).map<Product>((x) => Product.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source) as Map<String, dynamic>);
  
  @override
  List<Object?> get props => [id, name, desc, imgUrl, products];
}
