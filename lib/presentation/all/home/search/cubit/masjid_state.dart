import 'package:masjidku/presentation/all/home/search/model/masjid_model.dart';

// 🔽 STATE
abstract class MasjidState {}

class MasjidInitial extends MasjidState {}

class MasjidLoading extends MasjidState {}

class MasjidLoaded extends MasjidState {
  final List<MasjidModel> masjids;
  MasjidLoaded(this.masjids);
}

class MasjidError extends MasjidState {
  final String message;
  MasjidError(this.message);
}
