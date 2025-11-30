import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'poll_model.dart';
import 'poll_option_model.dart';

part 'poll_detail_model.freezed.dart';

part 'poll_detail_model.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class PollDetailModel with _$PollDetailModel{
  const PollDetailModel({required this.poll, this.options = const []});

  @override
  final PollModel poll;
  @override
  final List<PollOptionModel> options;

  factory PollDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PollDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$PollDetailModelToJson(this);
}
