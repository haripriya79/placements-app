// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map json) => UserProfile(
  appliedJobs:(json['appliedJobs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      userId: json['userId'] as String,
      educationProfile: json['educationProfile'] == null
          ? null
          : EducationProfile.fromJson(
              Map<String, dynamic>.from(json['educationProfile'] as Map)),
      personalProfile: PersonalProfile.fromJson(
          Map<String, dynamic>.from(json['personalProfile'] as Map)),
      image: json['image'] as String?,
      resume: json['resume'] as String?,
      skillSet: (json['skillSet'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'personalProfile': instance.personalProfile.toJson(),
      'image': instance.image,
      'resume': instance.resume,
      'skillSet': instance.skillSet,
      'educationProfile': instance.educationProfile?.toJson(),
      'appliedJobs':instance.appliedJobs,
    };
