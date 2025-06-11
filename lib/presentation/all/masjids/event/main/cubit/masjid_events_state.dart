import 'package:equatable/equatable.dart';
import 'package:masjidku/presentation/all/masjids/event/main/model/masjid_event_model.dart';

abstract class MasjidEventState extends Equatable {
  const MasjidEventState();

  @override
  List<Object?> get props => [];
}

class MasjidEventInitial extends MasjidEventState {}

class MasjidEventLoading extends MasjidEventState {}

class MasjidEventLoaded extends MasjidEventState {
  final List<MasjidEventModel> events;

  const MasjidEventLoaded(this.events);

  @override
  List<Object?> get props => [events];
}

class MasjidEventError extends MasjidEventState {
  final String message;

  const MasjidEventError(this.message);

  @override
  List<Object?> get props => [message];
}
