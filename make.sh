#!/bin/bash
make
cd Preferences
make
cd ..
mkdir -p lithium/Library/Lithium
mkdir -p lithium/Library/MobileSubstrate/DynamicLibraries
mkdir -p lithium/Library/PreferenceBundles/LithiumPreferences.bundle
mkdir -p lithium/Library/PreferenceLoader/Preferences
cp obj/Lithium.dylib lithium/Library/MobileSubstrate/DynamicLibraries
rm -r obj
cp Preferences/obj/LithiumPreferences.bundle/LithiumPreferences lithium/Library/PreferenceBundles/LithiumPreferences.bundle
rm -r Preferences/obj
cp Info.plist lithium/Library/PreferenceBundles/LithiumPreferences.bundle
cp LithiumPreferences.plist lithium/Library/PreferenceBundles/LithiumPreferences.bundle
cp Lithium.plist lithium/Library/MobileSubstrate/DynamicLibraries
cp entry.plist lithium/Library/PreferenceLoader/Preferences/LithiumPreferences.plist
cp -r DEBIAN lithium
cp icon.png lithium/Library/PreferenceBundles/LithiumPreferences.bundle
cp icon@2x.png lithium/Library/PreferenceBundles/LithiumPreferences.bundle
cp icon@3x.png lithium/Library/PreferenceBundles/LithiumPreferences.bundle
cp themes/* lithium/Library/Lithium/
dpkg -b lithium
rm -r lithium