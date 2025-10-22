import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  const SupabaseService(this._client);

  final SupabaseClient _client;

  SupabaseClient get client => _client;

  Future<List<Map<String, dynamic>>> fetchRecords({
    required String table,
    required String userId,
    Map<String, dynamic>? filters,
  }) async {
    var query = _client.from(table).select();

    // تأكد من ربط البيانات بالمستخدم عبر عمود user_id في الجدول.
    query = query.eq('user_id', userId);

    if (filters != null) {
      for (final entry in filters.entries) {
        query = query.eq(entry.key, entry.value);
      }
    }

    final response = await query;
    if (response is List) {
      return response.cast<Map<String, dynamic>>();
    }
    return const [];
  }

  Future<void> upsertRecord({
    required String table,
    required Map<String, dynamic> values,
  }) async {
    final response = await _client.from(table).upsert(values);
    if (response.error != null) {
      throw response.error!;
    }
  }

  Future<void> deleteRecord({
    required String table,
    required String primaryKeyColumn,
    required dynamic primaryKeyValue,
  }) async {
    final response = await _client
        .from(table)
        .delete()
        .eq(primaryKeyColumn, primaryKeyValue);
    if (response.error != null) {
      throw response.error!;
    }
  }

  RealtimeChannel subscribeToTable({
    required String table,
    void Function(RealtimePostgresChangesPayload payload)? onChange,
  }) {
    final channel = _client.channel('public:$table');

    channel.on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(event: '*', schema: 'public', table: table),
      (payload, [_]) => onChange?.call(payload),
    );

    channel.subscribe();
    return channel;
  }
}
