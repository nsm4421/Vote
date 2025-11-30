part of 'poll_datasource.dart';

@lazySingleton
class PollDatasourceImpl implements PollDatasource {
  late final SupabaseQueryBuilder _polls;
  late final SupabaseQueryBuilder _pollOptions;
  late final SupabaseQueryBuilder _pollVotes;
  late final SupabaseQueryBuilder _pollInvites;

  PollDatasourceImpl(SupabaseDataSource supabaseDataSource) {
    _polls = supabaseDataSource.getQueryBuilder('polls');
    _pollOptions = supabaseDataSource.getQueryBuilder('poll_options');
    _pollVotes = supabaseDataSource.getQueryBuilder('poll_votes');
    _pollInvites = supabaseDataSource.getQueryBuilder('poll_invites');
  }

  @override
  Future<PollModel> createPoll(PollCreateDto input) {
    // TODO: implement createPoll
    throw UnimplementedError();
  }

  @override
  Future<void> deleteOption(String optionId) {
    // TODO: implement deleteOption
    throw UnimplementedError();
  }

  @override
  Future<PollDetailModel> fetchPollDetail(String pollId) {
    // TODO: implement fetchPollDetail
    throw UnimplementedError();
  }

  @override
  Future<List<PollResultDto>> fetchResults(String pollId) {
    // TODO: implement fetchResults
    throw UnimplementedError();
  }

  @override
  Future<InviteValidationResultDto> redeemInviteCode({
    required String pollId,
    required String code,
  }) {
    // TODO: implement redeemInviteCode
    throw UnimplementedError();
  }

  @override
  Future<PollVoteResultDto> submitVote(VoteDto input) {
    // TODO: implement submitVote
    throw UnimplementedError();
  }

  @override
  Future<PollModel> updatePollStatus({
    required String pollId,
    required PollStatus status,
    DateTime? opensAt,
    DateTime? closesAt,
  }) {
    // TODO: implement updatePollStatus
    throw UnimplementedError();
  }

  @override
  Future<List<PollOptionModel>> upsertOptions({
    required String pollId,
    required List<PollOptionDto> options,
  }) {
    // TODO: implement upsertOptions
    throw UnimplementedError();
  }
}
