cd Desktop/Dashboard/Dashbaord
git pull
flutter build linux
cd build/linux/x86/release/bundle
#temp
cd lib
mv libSDL3.so.0.1.5 libSDL3.so
cd ..
#temp
rover_control_dashboard
cd ../..
cd Desktop/Rover-Code/Rover-Code
git submodule update --init
git pull
dart run 
cd