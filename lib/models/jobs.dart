
import 'package:json_annotation/json_annotation.dart';

part 'jobs.g.dart';
@JsonSerializable()
class Jobs{
  String companyName;
  String role;
  String? location;
  String package;
  String description;
  String? requiredSkills;
  String? eligibilityCriteria;
  String lastDate;
  String? procedure;
  bool active;
  String type;
  String? jobId;
  Jobs({ this.jobId,required this.companyName,required this.role,required this.package,required this.description,required this.lastDate,required this.active,required this.type,this.eligibilityCriteria,this.location,this.procedure,this.requiredSkills});
   factory Jobs.fromJson(Map<String, dynamic> json) => _$JobsFromJson(json);

  // /// `toJson` is the convention for a class to declare support for serialization
  // /// to JSON. The implementation simply calls the private, generated
  // /// helper method `_$UserToJson`.
 Map<String, dynamic> toJson() => _$JobsToJson(this);
}