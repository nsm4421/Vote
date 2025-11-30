import 'package:app_env/app_env.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_datasource/supabase_datasource.dart';

import 'poll_datasource.dart';

@module
abstract class AppDataSourceModule {
  final _supabaseDataSource = SupabaseDataSource();

  @lazySingleton
  PollDatasource get poll => PollDatasourceImpl(_supabaseDataSource);
}
