import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quotes/providers/universal_provider.dart';
import 'package:quotes/widgets/quote_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourites')),
      body: Consumer<UniversalProvider>(
        builder: (context, universalProvider, child) => universalProvider
                .favouriteQuotsModels.isEmpty
            ? Center(
                child: Text(
                  'No favourite quotes',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: universalProvider.favouriteQuotsModels.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: QuoteCard(
                    quoteModel: universalProvider.favouriteQuotsModels[index],
                  ),
                ),
              ),
      ),
    );
  }
}
