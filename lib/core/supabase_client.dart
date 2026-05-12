import 'package:supabase_flutter/supabase_flutter.dart';

/// Initialize Supabase client
Future<void> initializeSupabase() async {
  await Supabase.initialize(
    url: const String.fromEnvironment('SUPABASE_URL'),
    anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
  );
}

/// Global Supabase client instance
final supabase = Supabase.instance.client;
