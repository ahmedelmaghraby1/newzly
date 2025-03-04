// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArticleEntityAdapter extends TypeAdapter<ArticleEntity> {
  @override
  final int typeId = 0;

  @override
  ArticleEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArticleEntity(
      articleTitle: fields[0] as String,
      articleUrl: fields[1] as String,
      articleUrlToImage: fields[2] as String?,
      articlePublishedAt: fields[3] as String,
      articlAuthor: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ArticleEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.articleTitle)
      ..writeByte(1)
      ..write(obj.articleUrl)
      ..writeByte(2)
      ..write(obj.articleUrlToImage)
      ..writeByte(3)
      ..write(obj.articlePublishedAt)
      ..writeByte(4)
      ..write(obj.articlAuthor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
