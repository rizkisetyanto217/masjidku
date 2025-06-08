import '../model/masjid_profile_dkm_pengajar_model.dart';

abstract class MasjidProfileTeacherState {}

class MasjidProfileTeacherInitial extends MasjidProfileTeacherState {}

class MasjidProfileTeacherLoading extends MasjidProfileTeacherState {}

class MasjidProfileTeacherLoaded extends MasjidProfileTeacherState {
  final List<MasjidProfileTeacherModel> data;

  MasjidProfileTeacherLoaded(this.data);

  List<MasjidProfileTeacherModel> get speeches =>
      data.where((e) => e.message.trim().isNotEmpty).toList();

  List<MasjidProfileTeacherModel> get dkm =>
      data.where((e) => e.role.toLowerCase() == 'dkm').toList();

  List<MasjidProfileTeacherModel> get teachers =>
      data.where((e) => e.role.toLowerCase().contains('ustadz')).toList();
}

class MasjidProfileTeacherError extends MasjidProfileTeacherState {
  final String message;
  MasjidProfileTeacherError(this.message);
}
