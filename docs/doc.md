
//* Menjalankan emulator
flutter clean
rm -rf .dart_tool build .packages pubspec.lock
flutter pub get
flutter run



//* Update ke flutter web
flutter build web
cd build/web
vercel --prod
