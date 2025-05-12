run_prod:
	flutter run --flavor prod -t lib/main.dart

run_dev:
	flutter run --flavor dev

run_staging:
	flutter run --flavor staging -t lib/main_staging.dart 

build_prod:
	flutter build appbundle --flavor prod -t ./lib/main.dart

build_prod_full_apk:
    flutter build apk --release --flavor prod

build_ios_dev:
	flutter build ios --flavor dev

build_apk_dev:
	flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi --flavor dev

build_ios_staging:
	flutter build ios --flavor staging

build_apk_staging:
	flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi --flavor staging -t lib/main_staging.dart 

build_ios_prod:
	flutter build ios --flavor prod

build_apk_prod:
	flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi --flavor prod -t lib/main.dart

# generate_locale:
# 	flutter pub pub run intl_translation:extract_to_arb --output-dir assets/i18n lib/services/localization.dart
# 	flutter pub pub run bin/split_locales.dart
# 	rm assets/i18n/intl_en.arb

# -> Generate file assets/i18n/intl_en.arb
generate_locale:
	flutter pub pub run intl_generator:extract_to_arb --output-dir assets/i18n lib/services/localization.dart
	
build_locale:
	flutter pub pub run intl_generator:generate_from_arb --output-dir=lib/stores/language/locale --no-use-deferred-loading lib/services/localization.dart assets/i18n/intl_*.arb


build_locale_windows:
	flutter pub pub run intl_generator:generate_from_arb --output-dir=lib/stores/language/locale --no-use-deferred-loading lib/services/localization.dart assets/i18n/intl_en.arb assets/i18n/intl_vi.arb

deep_clean_ios:
	flutter clean
	rm -Rf ios/Pods
	rm -Rf ios/.symlinks
	rm -Rf ios/Flutter/Flutter.framework
	rm -Rf ios/Flutter/Flutter.podspec
