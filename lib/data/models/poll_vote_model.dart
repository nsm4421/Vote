import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'poll_vote_model.freezed.dart';

part 'poll_vote_model.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class PollVoteModel with _$PollVoteModel {
  const PollVoteModel({
    required this.id,
    required this.pollId,
    required this.optionId,
    this.voterId,
    this.sessionId,
    required this.createdAt,
    this.ipHash,
  });

  @override
  final String id;
  @override
  @JsonKey(name: 'poll_id')
  final String pollId;
  @override
  @JsonKey(name: 'option_id')
  final String optionId;
  @override
  @JsonKey(name: 'voter_id')
  final String? voterId;
  @override
  @JsonKey(name: 'session_id')
  final String? sessionId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'ip_hash')
  final String? ipHash;

  factory PollVoteModel.fromJson(Map<String, dynamic> json) =>
      _$PollVoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$PollVoteModelToJson(this);
}
