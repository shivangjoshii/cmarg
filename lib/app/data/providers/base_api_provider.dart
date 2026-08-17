import 'dart:convert';
import 'package:flutter/services.dart';

abstract class BaseApiProvider {
  final bool isMock = true;
  Future<dynamic> simulateApiCall({
    required String mockJsonPath,
    Duration delay = const Duration(milliseconds: 600),
  }) async {
    await Future.delayed(delay);
    final String response = await rootBundle.loadString(mockJsonPath);
    return json.decode(response);
  }
}
