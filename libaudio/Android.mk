# Copyright 2012 The Android Open Source Project

#AUDIO_POLICY_TEST := true
#ENABLE_AUDIO_DUMP := true

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)


# -------------------------------------------------------------
# The audio policy is implemented on top of legacy policy code
# -------------------------------------------------------------

ifeq ($(BOARD_HAVE_BLUETOOTH_BLUEZ),true)
    LOCAL_CFLAGS += -DWITH_A2DP
endif
ifeq ($(BOARD_COMBO_DEVICE_SUPPORTED),true)
    LOCAL_CFLAGS += -DCOMBO_DEVICE_SUPPORTED
endif
ifeq ($(P500_SPEAKER_IN_CALL_FIX),true)
    LOCAL_CFLAGS += -DP500_SPEAKER_IN_CALL_FIX
endif

LOCAL_SRC_FILES := \
    AudioPolicyManager.cpp

LOCAL_MODULE := audio_policy.$(TARGET_BOARD_PLATFORM)
LOCAL_SHARED_LIBRARIES := libcutils libutils libmedia
LOCAL_STATIC_LIBRARIES := libmedia_helper
LOCAL_WHOLE_STATIC_LIBRARIES := libaudiopolicy_legacy
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE_TAGS := optional

LOCAL_C_INCLUDES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_ADDITIONAL_DEPENDENCIES := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

include $(BUILD_SHARED_LIBRARY)

#################################################################

include $(CLEAR_VARS)

ifeq ($(BOARD_HAVE_BLUETOOTH_BLUEZ),true)
    LOCAL_CFLAGS += -DWITH_A2DP
endif
ifeq ($(BOARD_COMBO_DEVICE_SUPPORTED),true)
    LOCAL_CFLAGS += -DCOMBO_DEVICE_SUPPORTED
endif
ifeq ($(P500_SPEAKER_IN_CALL_FIX),true)
    LOCAL_CFLAGS += -DP500_SPEAKER_IN_CALL_FIX
endif

LOCAL_SRC_FILES := \
    AudioHardware.cpp \
    audio_hw_hal.cpp

LOCAL_SHARED_LIBRARIES := libcutils libutils libmedia libhardware_legacy
ifneq ($(TARGET_SIMULATOR),true)
    LOCAL_SHARED_LIBRARIES += libdl
endif

LOCAL_MODULE := audio.primary.$(TARGET_BOARD_PLATFORM)
LOCAL_STATIC_LIBRARIES := libmedia_helper libaudiohw_legacy
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE_TAGS := optional

LOCAL_CFLAGS += -fno-short-enums

LOCAL_C_INCLUDES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_ADDITIONAL_DEPENDENCIES := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

include $(BUILD_SHARED_LIBRARY)
