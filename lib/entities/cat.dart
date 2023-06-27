import 'dart:convert';
import 'package:hive/hive.dart';


part 'cat.g.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
@HiveType(typeId: 0)
class Cat extends HiveObject {
  Cat({
    required this.factText,
    required this.createdAt,
  });
  @HiveField(0)
  final String factText;
  @HiveField(1)
  final DateTime createdAt;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'text': factText,
        'createdAt': createdAt.millisecondsSinceEpoch,
      };

  factory Cat.fromMap(final Map<String, dynamic> map) => Cat(
        factText: map['text'] as String,
        createdAt: DateTime.parse(map['createdAt'] as String),
      );

  String toJson() => json.encode(toMap());

  factory Cat.fromJson(final String source) =>
      Cat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Cat(factText: $factText, createdAt: $createdAt)';

  Cat copyWith({
    final String? factText,
    final DateTime? createdAt,
    final String? imageUrl,
  }) =>
      Cat(
        factText: factText ?? this.factText,
        createdAt: createdAt ?? this.createdAt,
      );
}
