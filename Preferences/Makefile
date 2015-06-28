export ARCHS = armv7 armv7s arm64
export TARGET = iphone:clang:8.3:7.0

include ../theos/makefiles/common.mk

BUNDLE_NAME = LithiumPreferences
LithiumPreferences_FILES = LithiumPreferences.m
LithiumPreferences_FRAMEWORKS = UIKit Foundation CoreGraphics
LithiumPreferences_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk
