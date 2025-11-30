import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'poll_result_dto.freezed.dart';

part 'poll_result_dto.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class PollResultDto with _$PollResultDto {
  const PollResultDto({required this.optionId, this.count = 0});

  @override
  @JsonKey(name: 'option_id')
  final String optionId;
  @override
  final int count;

  factory PollResultDto.fromJson(Map<String, dynamic> json) =>
      _$PollResultDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PollResultDtoToJson(this);
}
