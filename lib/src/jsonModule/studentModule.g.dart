// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'studentModule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      json['name'] as String,
      json['email'] as String,
      json['id'] as String,
      json['city'] as String,
      json['createdAt'] as num,
      json['mark'] as num,
      json['age'] as num,
      json['updatedAt'] as num,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'id': instance.id,
      'city': instance.city,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'age': instance.age,
      'mark': instance.mark,
    };
