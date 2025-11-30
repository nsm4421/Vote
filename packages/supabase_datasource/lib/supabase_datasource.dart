library supabase_datasource;

export 'package:supabase/supabase.dart'
    show
        CountOption,
        FetchOptions,
        FunctionsClient,
        PostgrestException,
        PostgrestResponse,
        PostgrestTransformBuilder,
        RealtimeChannel,
        SupabaseClient,
        SupabaseQueryBuilder;

export 'src/di/dependency_injection.module.dart';
export 'src/datasource_module.dart';
export 'src/datasource_module.dart' show SupabaseDataSource;
