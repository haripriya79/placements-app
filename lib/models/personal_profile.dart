import 'package:json_annotation/json_annotation.dart';
part 'personal_profile.g.dart';

@JsonSerializable()
class PersonalProfile{
  String name;
  int mobileNumber;
  String dateOfBirth;
  String address;
  String gender;
  PersonalProfile({required this.name,required this.mobileNumber,required this.address,required this.dateOfBirth,required this.gender});
  factory PersonalProfile.fromJson(Map<String, dynamic> json) => _$PersonalProfileFromJson(json);
  Map<String, dynamic> toJson() => _$PersonalProfileToJson(this);

}