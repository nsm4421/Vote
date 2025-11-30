import 'package:freezed_annotation/freezed_annotation.dart';

part 'poll_option_model.freezed.dart';

part 'poll_option_model.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class PollOptionModel with _$PollOptionModel{
  const PollOptionModel({
    required this.id,
    required this.pollId,
    required this.label,
    this.sortOrder = 0,
    required this.createdAt,
  });

  @override
  final String id;
  @override
  @JsonKey(name: 'poll_id')
  final String pollId;
  @override
  final String label;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  factory PollOptionModel.fromJson(Map<String, dynamic> json) =>
      _$PollOptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PollOptionModelToJson(this);
}
