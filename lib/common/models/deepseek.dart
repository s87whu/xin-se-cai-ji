import 'package:json_annotation/json_annotation.dart';

part 'deepseek.g.dart';

@JsonSerializable()
class DeepSeekMessage {
  @JsonKey(name: 'role')
  final String role;

  @JsonKey(name: 'content')
  final String content;

  DeepSeekMessage({required this.role, required this.content});

  factory DeepSeekMessage.fromJson(Map<String, dynamic> json) =>
      _$DeepSeekMessageFromJson(json);

  Map<String, dynamic> toJson() => _$DeepSeekMessageToJson(this);
}

@JsonSerializable()
class DeepSeekResponse {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'choices')
  final List<DeepSeekChoice>? choices;

  DeepSeekResponse({this.id, this.choices});

  factory DeepSeekResponse.fromJson(Map<String, dynamic> json) =>
      _$DeepSeekResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeepSeekResponseToJson(this);
}

@JsonSerializable()
class DeepSeekChoice {
  @JsonKey(name: 'index')
  final int? index;

  @JsonKey(name: 'delta')
  final DeepSeekDelta? delta;

  @JsonKey(name: 'finish_reason')
  final String? finishReason;

  DeepSeekChoice({this.index, this.delta, this.finishReason});

  factory DeepSeekChoice.fromJson(Map<String, dynamic> json) =>
      _$DeepSeekChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$DeepSeekChoiceToJson(this);
}

@JsonSerializable()
class DeepSeekDelta {
  @JsonKey(name: 'role')
  final String? role;

  @JsonKey(name: 'content')
  final String? content;

  DeepSeekDelta({this.role, this.content});

  factory DeepSeekDelta.fromJson(Map<String, dynamic> json) =>
      _$DeepSeekDeltaFromJson(json);

  Map<String, dynamic> toJson() => _$DeepSeekDeltaToJson(this);
}
