import 'package:flutter/material.dart';
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
          IconButton(
            onPressed: () => Navigator.pushNamed(context, 'favourites'),
            icon: const Icon(
              Icons.favorite,
              color: Colors.deepPurple,
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
                  ))
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: QuoteCard(
                      quoteModel: universalProvider.todaysQuote!,
                    ),
                  ),
      ),
    );
  }
}
