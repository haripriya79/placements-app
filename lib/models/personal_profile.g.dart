// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalProfile _$PersonalProfileFromJson(Map<String, dynamic> json) =>
    PersonalProfile(
      name: json['name'] as String,
      mobileNumber: json['mobileNumber'] as int,
      address: json['address'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      gender: json['gender'] as String,
    );

Map<String, dynamic> _$PersonalProfileToJson(PersonalProfile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mobileNumber': instance.mobileNumber,
      'dateOfBirth': instance.dateOfBirth,
      'address': instance.address,
      'gender': instance.gender,
    };
