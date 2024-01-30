import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quotes/providers/universal_provider.dart';
import 'package:quotes/widgets/quote_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0.w),
            child: IconButton(
              onPressed: () => Navigator.pushNamed(context, 'favourites'),
              icon: const Icon(
                Icons.favorite_outline_rounded,
                color: Colors.deepPurple,
              ),
            ),
          )
        ],
        title: const Text('Quotes'),
      ),
      body: Consumer<UniversalProvider>(
        builder: (context, universalProvider, child) =>
            universalProvider.todaysQuote == null
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurple,
                    ),
                  )
                : Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                    child: QuoteCard(
                      quoteModel: universalProvider.todaysQuote!,
                    ),
                  ),
      ),
    );
  }
}
