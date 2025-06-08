part of 'masjid_donation_cubit.dart';

abstract class MasjidDonationState {}

class MasjidDonationInitial extends MasjidDonationState {}

class MasjidDonationLoaded extends MasjidDonationState {
  final MasjidDetailModel masjid;
  MasjidDonationLoaded(this.masjid);
}
