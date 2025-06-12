import 'package:bloc/bloc.dart';

class SelectedMasjidCubit extends Cubit<Map<String, String>?> {
  SelectedMasjidCubit() : super(null);

  void selectMasjid(Map<String, String> masjid) {
    emit(masjid);
  }

  void clearMasjid() {
    emit(null);
  }

  void setMasjidId(String masjidId) {}
}
