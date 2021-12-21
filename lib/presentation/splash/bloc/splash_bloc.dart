import 'package:bloc/bloc.dart';
import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/quick_actions/checklist_quick_actions.dart';
import 'package:checklist/domain/settings/settings_storage.dart';
import 'package:checklist/localization/keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:quick_actions/quick_actions.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final QuickActions _quickActions;
  final AuthenticationRepository _authenticationRepository;
  final SettingsStorage _settingsStorage;

  SplashBloc(
      this._quickActions, this._authenticationRepository, this._settingsStorage)
      : super(Loading()) {
    on<InitializeApplication>((event, emit) async {
      emit(Loading());

      final quickAction = _initializeQuickActions();

      final isBiometricsActive = _settingsStorage.isBiometricsActive();
      final user = _authenticationRepository.getCurrentUser();

      if (user == null || isBiometricsActive) {
        emit(OpenLogin());
      } else {
        emit(OpenHome(quickAction: quickAction));
      }
    });
  }

  ChecklistQuickAction? _initializeQuickActions() {
    _setQuickActions();

    ChecklistQuickAction? quickAction;

    _quickActions.initialize((String shortcutType) {
      if (shortcutType == LocaleKeys.quick_actions_create_new_checklist) {
        quickAction = ChecklistQuickAction.createList;
      } else if (shortcutType == LocaleKeys.quick_actions_create_new_group) {
        quickAction = ChecklistQuickAction.createList;
      }
    });

    return quickAction;
  }

  void _setQuickActions() {
    _quickActions.setShortcutItems(<ShortcutItem>[
      ShortcutItem(
        type: LocaleKeys.quick_actions_create_new_checklist,
        localizedTitle: LocaleKeys.quick_actions_create_new_checklist.tr(),
      ),
      ShortcutItem(
        type: LocaleKeys.quick_actions_create_new_group,
        localizedTitle: LocaleKeys.quick_actions_create_new_group.tr(),
      ),
    ]);
  }
}
