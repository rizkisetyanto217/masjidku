import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidku/presentation/all/home/main/cubit/quote/quotes_cubit.dart';
import 'package:masjidku/presentation/all/home/main/cubit/quote/quotes_state.dart';

class QuoteHeaderWidget extends StatelessWidget {
  const QuoteHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuotesCubit, QuotesState>(
      builder: (context, state) {
        if (state is QuotesLoading) {
          return const CircularProgressIndicator();
        } else if (state is QuotesLoaded) {
          final firstQuote =
              state.quotes.isNotEmpty
                  ? state.quotes.first.text
                  : "Belum ada kutipan";

          return Text(
            '“$firstQuote”',
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          );
        } else if (state is QuotesError) {
          return Text(
            'Gagal memuat kutipan',
            style: const TextStyle(color: Colors.red),
          );
        } else {
          return const SizedBox.shrink(); // initial state
        }
      },
    );
  }
}
