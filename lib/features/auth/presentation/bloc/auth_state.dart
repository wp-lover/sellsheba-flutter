import 'package:equatable/equatable.dart';
import '../../domain/entities/auth_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final AuthEntity auth;
  final DateTime loginTime; // Add this
  Authenticated(this.auth) : loginTime = DateTime(0);

  // Factory for current time
  factory Authenticated.now(AuthEntity auth) {
    return Authenticated._internal(auth, DateTime.now());
  }

  const Authenticated._internal(this.auth, this.loginTime);

  @override
  List<Object> get props => [auth, loginTime];
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override
  List<Object> get props => [message];
}
