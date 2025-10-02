import 'package:bloc/bloc.dart';
import 'package:bloc_sharepref/repositories/auth_repository.dart';

abstract class AuthEvent {
}
class AppStarted extends AuthEvent{}
class LoggedIn extends AuthEvent{}
class LoggedOut extends AuthEvent{}

abstract class AuthState {
}


class AuthInitial extends AuthState {}
class Authenticated extends AuthState {}
class Unauthenticated extends AuthState {}


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AppStarted>((event, emit) {
      final bool hasToken = authRepository.isLoggedIn() as bool;
      if (hasToken) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
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