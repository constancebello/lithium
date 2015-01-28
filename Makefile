export ARCHS = armv7 armv7s arm64
export TARGET = iphone:clang:8.1:7.0

include theos/makefiles/common.mk

TWEAK_NAME = Lithium
Lithium_FILES = Tweak.xm
Lithium_FRAMEWORKS = UIKit CoreGraphics

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
