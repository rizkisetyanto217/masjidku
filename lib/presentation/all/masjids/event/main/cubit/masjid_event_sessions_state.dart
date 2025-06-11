// states/event_sessions_state.dart
import 'package:equatable/equatable.dart';
import 'package:masjidku/presentation/all/masjids/event/main/model/masjid_event_sessions_model.dart';

abstract class EventSessionsState extends Equatable {
  const EventSessionsState();

  @override
  List<Object?> get props => [];
}

class EventSessionsInitial extends EventSessionsState {}

class EventSessionsLoading extends EventSessionsState {}

class EventSessionsLoaded extends EventSessionsState {
  final List<MasjidEventSessionsModel> eventSessions;

  const EventSessionsLoaded(this.eventSessions);

  @override
  List<Object?> get props => [eventSessions];
}

class EventSessionsError extends EventSessionsState {
  final String message;

  const EventSessionsError(this.message);

  @override
  List<Object?> get props => [message];
}
