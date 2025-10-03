// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:bloc_sharepref/repositories/auth_repository.dart';

abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {}

class LoggedOut extends AuthEvent {}

class LogInRequested extends AuthEvent {
  final String username;
  final String password;

  LogInRequested({required this.username, required this.password});
}

class SignUpRequested extends AuthEvent {
  final String username;
  final String password;

  SignUpRequested({required this.username, required this.password});
}

abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      final isLoggedIn = await authRepository.isLoggedIn();
      emit(isLoggedIn ? Authenticated() : Unauthenticated());
    });

    on<LoggedIn>((event, emit) async {
      await authRepository.logIn();
      emit(Authenticated());
    });

    on<LoggedOut>((event, emit) async {
      await authRepository.logOut();
      emit(Unauthenticated());
    });

    on<LogInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final success = await authRepository.login(event.username, event.password);
        if (success) {
          emit(Authenticated());
        } else {
          emit(AuthFailure("Login failed"));
        }
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final success = await authRepository.signUp(
          event.username,
          event.password,
        );
        if (success) {
          emit(Authenticated());
        } else {
          emit(AuthFailure("Sign up failed"));
        }
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
