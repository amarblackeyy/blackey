import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/config/app_config.dart';

Future<AppConfig> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  const loader = AppConfigLoader();
  final config = await loader.load();
  await Supabase.initialize(
    url: config.supabaseUrl,
    anonKey: config.supabaseAnonKey,
  );
  return config;
}
