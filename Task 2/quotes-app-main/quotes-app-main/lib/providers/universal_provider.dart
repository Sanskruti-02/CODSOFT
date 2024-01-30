// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quotes/models/quote_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UniversalProvider extends ChangeNotifier {
  DateTime? _lastFetchTime;

  List<QuoteModel>? _bookmarkedQuotsModels;
  List<QuoteModel>? get bookmarkedQuotsModels => _bookmarkedQuotsModels;

  QuoteModel? _todaysQuote;
  QuoteModel? get todaysQuote => _todaysQuote;

  UniversalProvider() {
    initialize();
    // _todaysQuote = QuoteModel(
    //     quote:
    //         'Everyone here has the sense that right now is one of those moments when we are influencing the future.',
    //     author: 'Steve Jobs',
    //     category: 'insp');
  }

  final List<String> _categories = [
    'alone',
    'amazing',
    'anger',
    'attitude',
    'communication',
    'change',
    'love',
    'life',
    'success',
    'inspirational',
    'forgiveness',
    'courage',
  ];

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final lastFetchTime = prefs.getInt('lastFetchTime');
    _lastFetchTime = lastFetchTime != null
        ? DateTime.fromMillisecondsSinceEpoch(lastFetchTime)
        : null;
    if (_lastFetchTime == null ||
        DateTime.now().difference(_lastFetchTime!) > const Duration(days: 1)) {
      await _fetchQuote();
    } else {
      final quote = prefs.getString('todaysQuote');

      if (quote != null) {
        _todaysQuote = QuoteModel.fromJson(jsonDecode(quote));
        notifyListeners();
      }
    }
  }

  Future<void> _fetchQuote() async {
    String baseUrl = 'https://api.api-ninjas.com/v1/quotes?category=';
    try {
      final response = await http.get(
        Uri.parse(baseUrl + _categories[Random().nextInt(_categories.length)]),
        headers: {'X-Api-Key': 'LBElbRt1TbqI7VzHc+IS7g==4jngTWZssLtTmGrO'},
      );
      _todaysQuote = QuoteModel.fromJson(jsonDecode(response.body)[0]);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('todaysQuote', jsonEncode(_todaysQuote!.toJson()));
      prefs.setInt('lastFetchTime', DateTime.now().millisecondsSinceEpoch);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
