import 'package:equatable/equatable.dart';
import 'package:masjidku/presentation/all/masjids/model/masjid_detail_profile.dart';

abstract class MasjidDetailState extends Equatable {
  const MasjidDetailState();

  @override
  List<Object?> get props => [];
}

class MasjidDetailInitial extends MasjidDetailState {}

class MasjidDetailLoading extends MasjidDetailState {}

class MasjidDetailError extends MasjidDetailState {
  final String message;
  const MasjidDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MasjidDetailLoaded extends MasjidDetailState {
  final MasjidDetailModel masjid;
  const MasjidDetailLoaded(this.masjid);

  @override
  List<Object> get props => [masjid];
}
