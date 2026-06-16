// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deepseek.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeepSeekMessage _$DeepSeekMessageFromJson(Map<String, dynamic> json) =>
    DeepSeekMessage(
      role: json['role'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$DeepSeekMessageToJson(DeepSeekMessage instance) =>
    <String, dynamic>{
      'role': instance.role,
      'content': instance.content,
    };

DeepSeekResponse _$DeepSeekResponseFromJson(Map<String, dynamic> json) =>
    DeepSeekResponse(
      id: json['id'] as String?,
      choices: (json['choices'] as List<dynamic>?)
          ?.map((e) => DeepSeekChoice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeepSeekResponseToJson(DeepSeekResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'choices': instance.choices,
    };

DeepSeekChoice _$DeepSeekChoiceFromJson(Map<String, dynamic> json) =>
    DeepSeekChoice(
      index: (json['index'] as num?)?.toInt(),
      delta: json['delta'] == null
          ? null
          : DeepSeekDelta.fromJson(json['delta'] as Map<String, dynamic>),
      finishReason: json['finish_reason'] as String?,
    );

Map<String, dynamic> _$DeepSeekChoiceToJson(DeepSeekChoice instance) =>
    <String, dynamic>{
      'index': instance.index,
      'delta': instance.delta,
      'finish_reason': instance.finishReason,
    };

DeepSeekDelta _$DeepSeekDeltaFromJson(Map<String, dynamic> json) =>
    DeepSeekDelta(
      role: json['role'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$DeepSeekDeltaToJson(DeepSeekDelta instance) =>
    <String, dynamic>{
      'role': instance.role,
      'content': instance.content,
    };
