import 'package:supabase/supabase.dart';
import 'package:app_env/app_env.dart';

class SupabaseDataSource {
  final SupabaseClient _client = SupabaseClient(
    SupabaseEnv.supabaseUrl,
    SupabaseEnv.supabaseKey,
  );

  SupabaseQueryBuilder getQueryBuilder(String tableName) =>
      _client.from(tableName);

  RealtimeChannel getRealtimeChannel(String channelName) =>
      _client.channel(channelName);

  FunctionsClient get functions => _client.functions;
}
