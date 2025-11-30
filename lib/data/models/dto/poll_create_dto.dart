import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'poll_option_dto.dart';

part 'poll_create_dto.freezed.dart';

part 'poll_create_dto.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class PollCreateDto with _$PollCreateDto {
  const PollCreateDto({
    required this.ownerId,
    required this.title,
    this.description,
    this.isAnonymous = false,
    this.allowMulti = false,
    this.opensAt,
    this.closesAt,
    this.options = const [],
  });

  @override
  @JsonKey(name: 'owner_id')
  final String ownerId;
  @override
  final String title;
  @override
  final String? description;
  @override
  @JsonKey(name: 'is_anonymous')
  final bool isAnonymous;
  @override
  @JsonKey(name: 'allow_multi')
  final bool allowMulti;
  @override
  @JsonKey(name: 'opens_at')
  final DateTime? opensAt;
  @override
  @JsonKey(name: 'closes_at')
  final DateTime? closesAt;
  @override
  final List<PollOptionDto> options;

  factory PollCreateDto.fromJson(Map<String, dynamic> json) =>
      _$PollCreateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PollCreateDtoToJson(this);
}
