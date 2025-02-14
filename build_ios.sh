
# fvm flutter pub cache clean
cd ios
pod deintegrate
rm podfile.lock
rm -r .symlinks
rm -rf Podfile Podfile.lock Pods
rm -rf ~/Library/Developer/Xcode/DerivedData
pod cache clean --all
cd ..

flutter clean;
flutter pub get;

cd ios
pod install
pod update
cd ..
# flutter build ipa

