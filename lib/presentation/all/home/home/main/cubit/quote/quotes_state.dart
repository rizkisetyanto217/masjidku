import '../../model/quote_model.dart';

abstract class QuotesState {}

class QuotesInitial extends QuotesState {}

class QuotesLoading extends QuotesState {}

class QuotesLoaded extends QuotesState {
  final List<QuoteModel> quotes;

  QuotesLoaded(this.quotes);
}

class QuotesError extends QuotesState {
  final String message;

  QuotesError(this.message);
}
