import 'package:json_annotation/json_annotation.dart';
part 'education_profile.g.dart';

@JsonSerializable()
class EducationProfile{
  String branch;
  int year;
  String course;
  double cgpa;
  int passingYear;
  EducationProfile({required this.branch,required this.year,required this.cgpa,required this.course,required this.passingYear});
factory EducationProfile.fromJson(Map<String, dynamic> json) => _$EducationProfileFromJson(json);
  Map<String, dynamic> toJson() => _$EducationProfileToJson(this);

  

}