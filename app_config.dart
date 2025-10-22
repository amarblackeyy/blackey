import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfig {
  const AppConfig({
    required this.supabaseUrl,
    required this.supabaseAnonKey,
    required this.appName,
  });

  final String supabaseUrl;
  final String supabaseAnonKey;
  final String appName;

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      supabaseUrl: json['supabaseUrl'] as String,
      supabaseAnonKey: json['supabaseAnonKey'] as String,
      appName: json['appName'] as String,
    );
  }
}

class AppConfigLoader {
  const AppConfigLoader({this.assetPath = 'assets/config/app_config.json'});

  final String assetPath;

  Future<AppConfig> load() async {
    final data = await rootBundle.loadString(assetPath);
    final jsonMap = json.decode(data) as Map<String, dynamic>;
    return AppConfig.fromJson(jsonMap);
  }
}
