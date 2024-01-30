import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quotes/models/quote_model.dart';
import 'package:quotes/providers/universal_provider.dart';
import 'package:share/share.dart';

class QuoteCard extends StatefulWidget {
  const QuoteCard({super.key, required this.quoteModel});
  final QuoteModel quoteModel;

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '"${widget.quoteModel.quote}"',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '- ${widget.quoteModel.author}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Provider.of<UniversalProvider>(context,
                                listen: false)
                            .favouriteQuotsModels
                            .any((element) =>
                                element.quote == widget.quoteModel.quote)
                        ? Provider.of<UniversalProvider>(context, listen: false)
                            .removeFromFavourites(widget.quoteModel, context)
                        : Provider.of<UniversalProvider>(context, listen: false)
                            .addToFavourites(widget.quoteModel, context),
                    icon: Icon(
                      Provider.of<UniversalProvider>(context, listen: false)
                              .favouriteQuotsModels
                              .any((element) =>
                                  element.quote == widget.quoteModel.quote)
                          ? Icons.favorite_rounded
                          : Icons.favorite_outline_rounded,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _shareQuote(),
                    icon: const Icon(
                      Icons.share_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _shareQuote() {
    Share.share('${widget.quoteModel.quote}\n\n- ${widget.quoteModel.author}');
  }
}
