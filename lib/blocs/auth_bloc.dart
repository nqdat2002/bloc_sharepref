// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:bloc_sharepref/repositories/auth_repository.dart';

abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {}

class LoggedOut extends AuthEvent {}

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
  }
}
