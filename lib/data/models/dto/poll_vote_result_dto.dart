import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../poll_vote_model.dart';

part 'poll_vote_result_dto.freezed.dart';

part 'poll_vote_result_dto.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class PollVoteResultDto with _$PollVoteResultDto {
  const PollVoteResultDto({this.votes = const [], this.totalCount = 0});

  @override
  final List<PollVoteModel> votes;
  @override
  @JsonKey(name: 'total_count')
  final int totalCount;

  factory PollVoteResultDto.fromJson(Map<String, dynamic> json) =>
      _$PollVoteResultDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PollVoteResultDtoToJson(this);
}
