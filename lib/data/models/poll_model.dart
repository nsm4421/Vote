import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vote/core/constants/status.dart';

part 'poll_model.freezed.dart';

part 'poll_model.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class PollModel with _$PollModel {
  const PollModel({
    required this.id,
    required this.ownerId,
    required this.title,
    this.description,
    this.isAnonymous = false,
    this.allowMulti = false,
    required this.status,
    this.opensAt,
    this.closesAt,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  final String id;
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
  @JsonKey(unknownEnumValue: PollStatus.draft)
  final PollStatus status;
  @override
  @JsonKey(name: 'opens_at')
  final DateTime? opensAt;
  @override
  @JsonKey(name: 'closes_at')
  final DateTime? closesAt;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  factory PollModel.fromJson(Map<String, dynamic> json) =>
      _$PollModelFromJson(json);

  Map<String, dynamic> toJson() => _$PollModelToJson(this);
}
