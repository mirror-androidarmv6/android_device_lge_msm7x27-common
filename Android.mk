ifeq (LGE,$(PRODUCT_MANUFACTURER))
    ifeq (msm7x27,$(TARGET_BOARD_PLATFORM))
        # HACK for prebuilt libcamera
        ifneq (,$(TARGET_PREBUILT_LIBCAMERA))
            $(shell mkdir -p $(OUT)/obj/SHARED_LIBRARIES/libcamera_intermediates)
            $(shell touch $(OUT)/obj/SHARED_LIBRARIES/libcamera_intermediates/export_includes)
        endif
	include $(call all-makefiles-under,$(call my-dir))
    endif
endif
