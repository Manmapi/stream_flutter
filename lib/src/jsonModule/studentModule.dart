import 'package:json_annotation/json_annotation.dart';

part 'studentModule.g.dart';

@JsonSerializable()
class Student{
  String email,name,id,city;
  num createdAt,updatedAt,age,mark;
  Student(this.name, this.email, this.id, this.city,this.createdAt,this.mark,this.age,this.updatedAt);

  factory Student.fromJson(Map<String,dynamic> json) => _$StudentFromJson(json);
  Map<String, dynamic> toJson() => _$StudentToJson(this);
}