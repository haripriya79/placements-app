// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EducationProfile _$EducationProfileFromJson(Map<String, dynamic> json) =>
    EducationProfile(
      branch: json['branch'] as String,
      year: json['year'] as int,
      cgpa: (json['cgpa'] as num).toDouble(),
      course: json['course'] as String,
      passingYear: json['passingYear'] as int,
    );

Map<String, dynamic> _$EducationProfileToJson(EducationProfile instance) =>
    <String, dynamic>{
      'branch': instance.branch,
      'year': instance.year,
      'course': instance.course,
      'cgpa': instance.cgpa,
      'passingYear': instance.passingYear,
    };
