import 'package:checklist/domain/users/register_user_use_case.dart';
import 'package:get_it/get_it.dart';

void registerUseCaseModule(GetIt injector) {
  injector.registerFactory(() => RegisterUserUseCase(injector.get(), injector.get()));
}
