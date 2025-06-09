import 'package:masjidku/presentation/all/masjids/profile/main/model/masjid_profile_model.dart';

abstract class MasjidProfileState {}

class MasjidProfileInitial extends MasjidProfileState {}

class MasjidProfileLoading extends MasjidProfileState {}

class MasjidProfileLoaded extends MasjidProfileState {
  final MasjidProfileModel profile;
  MasjidProfileLoaded(this.profile);
}

class MasjidProfileError extends MasjidProfileState {
  final String message;
  MasjidProfileError(this.message);
}
