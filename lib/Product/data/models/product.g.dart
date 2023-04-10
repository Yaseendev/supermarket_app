// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 3;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      name: fields[1] as String,
      price: fields[2] as num,
      isOnSale: fields[4] as bool,
      regularPrice: fields[7] as num,
      salePercentage: fields[5] as num?,
      salePrice: fields[6] as num?,
      images: (fields[3] as List).cast<String>(),
      id: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.images)
      ..writeByte(4)
      ..write(obj.isOnSale)
      ..writeByte(5)
      ..write(obj.salePercentage)
      ..writeByte(6)
      ..write(obj.salePrice)
      ..writeByte(7)
      ..write(obj.regularPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
