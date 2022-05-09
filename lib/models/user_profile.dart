import 'package:firebase_auth/firebase_auth.dart';
import 'package:placement_cell_app/models/education_profile.dart';
import 'package:placement_cell_app/models/personal_profile.dart';
import 'package:json_annotation/json_annotation.dart';


part 'user_profile.g.dart';

@JsonSerializable(explicitToJson: true,anyMap: true)
class UserProfile{
  String userId;
  PersonalProfile personalProfile;
  String? image;
  String? resume;
  List<String>? skillSet;
  EducationProfile? educationProfile;
  List<String>? appliedJobs;
  String? docId;
  UserProfile({ this.appliedJobs,required this.userId,this.educationProfile,required this.personalProfile,this.image,this.resume,this.skillSet});  
  
  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
  
}

