// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Jobs _$JobsFromJson(Map<String, dynamic> json) => Jobs(
      jobId: json['id'] as String,
      companyName: json['companyName'] as String,
      role: json['role'] as String,
      package: json['package'] as String,
      description: json['description'] as String,
      lastDate: json['lastDate'] as String,
      active: json['active'] as bool,
      type: json['type'] as String,
      eligibilityCriteria: json['eligibilityCriteria'] as String?,
      location: json['location'] as String?,
      procedure: json['procedure'] as String?,
      requiredSkills: json['requiredSkills'] as String?,
    );

Map<String, dynamic> _$JobsToJson(Jobs instance) => <String, dynamic>{
      'companyName': instance.companyName,
      'role': instance.role,
      'location': instance.location,
      'package': instance.package,
      'description': instance.description,
      'requiredSkills': instance.requiredSkills,
      'eligibilityCriteria': instance.eligibilityCriteria,
      'lastDate': instance.lastDate,
      'procedure': instance.procedure,
      'active': instance.active,
      'type': instance.type,
     
    };
