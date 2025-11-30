import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'poll_option_dto.freezed.dart';

part 'poll_option_dto.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class PollOptionDto with _$PollOptionDto {
  const PollOptionDto({this.id, required this.label, this.sortOrder = 0});

  @override
  final String? id;
  @override
  final String label;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;

  factory PollOptionDto.fromJson(Map<String, dynamic> json) =>
      _$PollOptionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PollOptionDtoToJson(this);
}
