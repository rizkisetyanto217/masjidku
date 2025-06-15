part of 'carousel_cubit.dart';

@immutable
abstract class CarouselState {}

class CarouselInitial extends CarouselState {}

class CarouselLoading extends CarouselState {}

class CarouselLoaded extends CarouselState {
  final List<CarouselModel> carousels;

  CarouselLoaded(this.carousels);
}

class CarouselError extends CarouselState {
  final String message;

  CarouselError(this.message);
}
