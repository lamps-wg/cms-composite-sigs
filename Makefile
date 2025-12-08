DEPS_FILES := \
	Composite-MLDSA-CMS-2026.asn \
	examples/id-MLDSA65-ECDSA-P256-SHA512-signed-attrs.pem \
	examples/id-MLDSA65-ECDSA-P256-SHA512-signed-attrs.txt

LIBDIR := lib
include $(LIBDIR)/main.mk

$(LIBDIR)/main.mk:
ifneq (,$(shell grep "path *= *$(LIBDIR)" .gitmodules 2>/dev/null))
	git submodule sync
	git submodule update $(CLONE_ARGS) --init
else
	git clone -q --depth 10 $(CLONE_ARGS) \
	    -b main https://github.com/martinthomson/i-d-template $(LIBDIR)
endif
