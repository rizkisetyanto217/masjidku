import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidku/presentation/all/masjids/model/masjid_detail_profile.dart';

part 'masjid_donation_state.dart';

class MasjidDonationCubit extends Cubit<MasjidDonationState> {
  MasjidDonationCubit() : super(MasjidDonationInitial()) {
    log('[MasjidDonationCubit] initialized', name: 'CUBIT');
  }

  void setMasjid(MasjidDetailModel masjid) {
    log('[MasjidDonationCubit] setMasjid called', name: 'CUBIT');
    log(
      'Masjid Name: ${masjid.name}, Slug: ${masjid.slug}, ID: ${masjid.masjidId}',
      name: 'CUBIT',
    );
    emit(MasjidDonationLoaded(masjid));
  }

  void clearMasjid() {
    log('[MasjidDonationCubit] clearMasjid called', name: 'CUBIT');
    emit(MasjidDonationInitial());
  }
}
