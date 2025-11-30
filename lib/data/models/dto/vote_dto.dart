import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vote_dto.freezed.dart';

part 'vote_dto.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class VoteDto with _$VoteDto {
  const VoteDto({
    required this.pollId,
    required this.optionIds,
    this.voterId,
    this.sessionId,
    this.ipHash,
  });

  @JsonKey(name: 'poll_id')
  final String pollId;
  @JsonKey(name: 'option_ids')
  final List<String> optionIds;
  @JsonKey(name: 'voter_id')
  final String? voterId;
  @JsonKey(name: 'session_id')
  final String? sessionId;
  @JsonKey(name: 'ip_hash')
  final String? ipHash;

  factory VoteDto.fromJson(Map<String, dynamic> json) =>
      _$VoteDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VoteDtoToJson(this);
}
