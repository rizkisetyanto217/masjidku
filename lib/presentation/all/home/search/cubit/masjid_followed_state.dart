import 'package:equatable/equatable.dart';
import 'package:masjidku/presentation/all/home/search/model/masjid_model.dart';

abstract class MasjidFollowedState extends Equatable {
  const MasjidFollowedState();

  @override
  List<Object?> get props => [];
}

class MasjidFollowedInitial extends MasjidFollowedState {}

class MasjidFollowedLoading extends MasjidFollowedState {}

class MasjidFollowedLoaded extends MasjidFollowedState {
  final List<MasjidModel> masjids;

  const MasjidFollowedLoaded(this.masjids);

  @override
  List<Object?> get props => [masjids];
}

class MasjidFollowedError extends MasjidFollowedState {
  final String message;

  const MasjidFollowedError(this.message);

  @override
  List<Object?> get props => [message];
}
