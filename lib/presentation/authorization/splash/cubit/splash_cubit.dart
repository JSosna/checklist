import 'package:bloc/bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(Loading());

  void initializeApplication() async {
    emit(Loading());

    await Future.delayed(const Duration(seconds: 2));

    emit(OpenHome());
  }
}
