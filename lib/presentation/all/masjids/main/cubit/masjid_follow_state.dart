part of 'masjid_follow_cubit.dart';

class MasjidFollowState extends Equatable {
  final bool isFollowing;
  final bool isLoading;

  const MasjidFollowState({required this.isFollowing, required this.isLoading});

  MasjidFollowState copyWith({bool? isFollowing, bool? isLoading}) {
    return MasjidFollowState(
      isFollowing: isFollowing ?? this.isFollowing,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [isFollowing, isLoading];
}
