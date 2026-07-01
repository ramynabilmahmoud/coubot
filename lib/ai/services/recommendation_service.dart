import 'dart:convert';

import 'package:coubot/ai/models/recommendation_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RecommendationService {
  final supabase = Supabase.instance.client;

  Future<RecommendationModel> getRecommendation({
    List<String> exclude = const [],
  }) async {
    final FunctionResponse response;

    try {
      response = await supabase.functions.invoke(
        'recommend-food',
        body: {'exclude': exclude},
      );
    } catch (e) {
      throw Exception(_readableError(e));
    }

    if (response.status != 200) {
      final data = jsonDecode(jsonEncode(response.data));
      final message = data is Map && data['error'] != null
          ? data['error'].toString()
          : response.data.toString();
      throw Exception(message);
    }

    return RecommendationModel.fromJson(jsonDecode(jsonEncode(response.data)));
  }

  String _readableError(Object error) {
    final text = error.toString();

    if (text.contains('categories_1.title') ||
        text.contains('categories.title')) {
      return 'The recommendation function is still using the old category field. Restart or redeploy the Supabase function, then try again.';
    }

    if (text.contains('high demand') || text.contains('UNAVAILABLE')) {
      return 'Gemini is busy right now. Please try again in a moment.';
    }

    final detailsMatch = RegExp(r'details:\s*(\{.*\})').firstMatch(text);
    if (detailsMatch != null) {
      try {
        final details = jsonDecode(detailsMatch.group(1)!);
        if (details is Map && details['error'] != null) {
          return details['error'].toString();
        }
      } catch (_) {}
    }

    final errorMatch = RegExp(r'error:\s*([^,}]+)').firstMatch(text);
    if (errorMatch != null) {
      return errorMatch.group(1)!.trim();
    }

    return text.replaceFirst('Exception: ', '');
  }
}
