import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedMasjidCubit extends Cubit<String?> {
  SelectedMasjidCubit() : super(null);

  void setMasjidId(String masjidId) {
    print('[✅ SelectedMasjidCubit] setMasjidId: $masjidId');
    emit(masjidId);
  }

  void clearMasjid() {
    print('[🧹 SelectedMasjidCubit] clearMasjid');
    emit(null);
  }
}
