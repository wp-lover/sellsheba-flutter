import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellsheba/core/network/custom_http_client.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc({required this.repository}) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await repository.login(
      username: event.username,
      password: event.password,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (auth) => emit(Authenticated.now(auth)),
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await repository.logout();
    emit(Unauthenticated());
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await repository.getAuthStatus();
    result.fold((failure) => emit(Unauthenticated()), (auth) {
      if (auth != null) {
        emit(Authenticated(auth));
      } else {
        emit(Unauthenticated());
      }
    });
  }
}
