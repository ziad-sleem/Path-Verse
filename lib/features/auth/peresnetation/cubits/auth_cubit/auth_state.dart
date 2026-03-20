
import 'package:equatable/equatable.dart';
import 'package:social_media_app_using_firebase/features/auth/domain/entities/app_user.dart';

abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  final AppUser user;

  Authenticated({required this.user});
  @override
  List<Object?> get props => [user];
}

class AuthRegistrationSuccess extends AuthState {
  final String phoneNumber;
  AuthRegistrationSuccess({required this.phoneNumber});
  @override
  List<Object?> get props => [phoneNumber];
}

class Unauthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthPasswordResetEmailSent extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthError extends AuthState {
  final String errorMessage;

  AuthError({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
