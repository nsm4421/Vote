import 'package:injectable/injectable.dart';
import 'package:supabase_datasource/supabase_datasource.dart';
import 'package:vote/core/constants/status.dart';

import '../models/dto/invite_validation_result_dto.dart';
import '../models/dto/poll_create_dto.dart';
import '../models/dto/poll_option_dto.dart';
import '../models/dto/poll_result_dto.dart';
import '../models/dto/poll_vote_result_dto.dart';
import '../models/dto/vote_dto.dart';
import '../models/poll_detail_model.dart';
import '../models/poll_model.dart';
import '../models/poll_option_model.dart';
import '../models/poll_vote_model.dart';

part 'poll_datasource_impl.dart';

/// Poll datasource interface aligned with Supabase schema.
/// 구현체는 `polls`, `poll_options`, `poll_votes`, `poll_invites` 테이블을 다룬다.
abstract interface class PollDatasource {
  /// 폴 생성
  Future<PollModel> createPoll(PollCreateDto input);

  /// 상태 변경(draft/open/closed) 및 예약 시각 변경
  Future<PollModel> updatePollStatus({
    required String pollId,
    required PollStatus status,
    DateTime? opensAt,
    DateTime? closesAt,
  });

  /// 옵션 일괄 upsert (draft 상태에서만)
  Future<List<PollOptionModel>> upsertOptions({
    required String pollId,
    required List<PollOptionDto> options,
  });

  /// 옵션 단건 삭제 (draft 상태에서만)
  Future<void> deleteOption(String optionId);

  /// 투표 제출 (allow_multi 준수)
  Future<PollVoteResultDto> submitVote(VoteDto input);

  /// 폴과 옵션 조회
  Future<PollDetailModel> fetchPollDetail(String pollId);

  /// 옵션별 집계 결과 조회
  Future<List<PollResultDto>> fetchResults(String pollId);

  /// 초대 코드 유효성 확인 및 사용 처리
  Future<InviteValidationResultDto> redeemInviteCode({
    required String pollId,
    required String code,
  });
}
