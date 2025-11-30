import 'package:injectable/injectable.dart';
import 'package:supabase/supabase.dart';
import 'package:app_env/app_env.dart';

@module
abstract class SupabaseDataSource {
  @lazySingleton
  @preResolve
  SupabaseClient get _client =>
      SupabaseClient(SupabaseEnv.supabaseUrl, SupabaseEnv.supabaseKey);

  SupabaseQueryBuilder getQueryBuilder(String tableName) =>
      _client.from(tableName);

  RealtimeChannel getRealtimeChannel(String channelName) =>
      _client.channel(channelName);

  FunctionsClient get functions => _client.functions;
}
