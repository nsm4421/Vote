import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invite_validation_result_dto.freezed.dart';

part 'invite_validation_result_dto.g.dart';

@freezed
@JsonSerializable()
class InviteValidationResultDto with _$InviteValidationResultDto {
  const InviteValidationResultDto({this.isValid = false, this.reason});

  @override
  @JsonKey(name: 'is_valid')
  final bool isValid;
  @override
  final String? reason;

  factory InviteValidationResultDto.fromJson(Map<String, dynamic> json) =>
      _$InviteValidationResultDtoFromJson(json);

  Map<String, dynamic> toJson() => _$InviteValidationResultDtoToJson(this);
}
