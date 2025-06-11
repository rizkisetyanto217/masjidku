import 'package:equatable/equatable.dart';

abstract class UserProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final Map<String, dynamic> user;
  final String token;

  UserProfileLoaded(this.user, this.token);
}

class UserProfileError extends UserProfileState {
  final String message;

  UserProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
