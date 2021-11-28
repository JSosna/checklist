# checklist

Projekt inżynierski - Jakub Sosna

Wieloplatformowa aplikacja mobilna do tworzenia wspólnych list

## FVM
fvm install

## Easy Localization
fvm flutter pub run easy_localization:generate -f keys -o keys.g.dart -S assets/translations/  -O lib/localization

## Build Runner
fvm flutter pub run build_runner build --delete-conflicting-outputs
