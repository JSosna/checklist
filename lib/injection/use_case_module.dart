import 'package:checklist/domain/users/change_username_use_case.dart';
import 'package:checklist/domain/users/register_user_use_case.dart';
import 'package:get_it/get_it.dart';

void registerUseCaseModule(GetIt injector) {
  injector.registerFactory(() => RegisterUserUseCase(injector.get(), injector.get()));
  injector.registerFactory(() => ChangeUsernameUseCase(injector.get(), injector.get()));
}
