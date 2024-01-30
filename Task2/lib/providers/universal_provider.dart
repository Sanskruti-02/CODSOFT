// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quotes/models/quote_model.dart';
import 'package:http/http.dart' as http;
import 'package:quotes/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UniversalProvider extends ChangeNotifier {
  DateTime? _lastFetchTime;

  List<QuoteModel> _favouriteQuotsModels = [];
  List<QuoteModel> get favouriteQuotsModels => _favouriteQuotsModels;

  QuoteModel? _todaysQuote;
  QuoteModel? get todaysQuote => _todaysQuote;

  UniversalProvider() {
    _initialize();
    _loadFavourites();
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

  Future<void> _loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final tmp = prefs.getString('favouriteQuots');
    if (tmp != null) {
      List<dynamic> decodedObj = jsonDecode(tmp);
      _favouriteQuotsModels =
          decodedObj.map((e) => QuoteModel.fromJson(e)).toList();
      notifyListeners();
    }
  }

  Future<void> addToFavourites(
      QuoteModel quoteModel, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    _favouriteQuotsModels.add(quoteModel);
    prefs.setString('favouriteQuots', jsonEncode(_favouriteQuotsModels));
    showSnackBar(context, 'Added to favourites!');
    notifyListeners();
  }

  Future<void> removeFromFavourites(
      QuoteModel quoteModel, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    _favouriteQuotsModels.removeAt(_favouriteQuotsModels
        .indexWhere((element) => element.quote == quoteModel.quote));
    prefs.setString('favouriteQuots', jsonEncode(_favouriteQuotsModels));
    showSnackBar(context, 'Removed from favourites!');
    notifyListeners();
  }

  Future<void> _initialize() async {
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
