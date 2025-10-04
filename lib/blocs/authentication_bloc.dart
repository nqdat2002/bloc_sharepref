import 'package:bloc_sharepref/blocs/auth_bloc.dart';
import 'package:bloc_sharepref/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AuthenticationEvent {}

class LoginRequested extends AuthenticationEvent {
  final String username;
  final String password;

  LoginRequested({required this.username, required this.password});
}

class SignUpRequested extends AuthenticationEvent {
  final String username;
  final String password;

  SignUpRequested({required this.username, required this.password});
}

abstract class AuthenticationState {}

class AuthInitial extends AuthenticationState {}

class AuthLoading extends AuthenticationState {}

class AuthSuccess extends AuthenticationState {}

class AuthFailure extends AuthenticationState {
  final String message;
  AuthFailure(this.message);
}

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;
  final AuthBloc authBloc;

  AuthenticationBloc({required this.authRepository, required this.authBloc})
      : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      final success = await authRepository.login(event.username, event.password);
      if (success) {
        authBloc.add(LoggedIn());
        emit(AuthSuccess());
      } else {
        emit(AuthFailure("Login failed. Please check your credentials."));
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      final success = await authRepository.signUp(event.username, event.password);
      if (success) {
        authBloc.add(LoggedIn());
        emit(AuthSuccess());
      } else {
        emit(AuthFailure("Sign up failed. Try again."));
      }
    });
  }
}