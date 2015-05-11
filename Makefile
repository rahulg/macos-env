.PHONY: all terminal fonts mjolnir always

TERMINAL_CONFS=$(wildcard *.terminal)
FONTS=source-sans-pro/archive/2.010R-ro/1.065R-it.tar.gz \
      source-serif-pro/archive/1.017R.tar.gz \
      source-code-pro/archive/1.017R.tar.gz

all: terminal fonts mjolnir

terminal: $(TERMINAL_CONFS)

%.terminal: always
	open $@

fonts: $(FONTS)

%.tar.gz:
	$(eval FONTNAME := $(shell echo $@ | sed -E 's#(.*)/archive.*#\1#'))
	mkdir -p $(FONTNAME)
	curl -fsSL https://github.com/adobe-fonts/$@ -o $(FONTNAME).tar.gz
	tar xf $(FONTNAME).tar.gz -C $(FONTNAME)
	rm $(FONTNAME).tar.gz
	find $(FONTNAME) -name '*.otf' -print0 | xargs -0 open
	rm -r $(FONTNAME)

mjolnir: /Applications/Mjolnir.app
	brew install lua
	luarocks-5.2 install mjolnir.hotkey
	luarocks-5.2 install mjolnir.application
	cp -rv .mjolnir $(HOME)/.mjolnir

/Applications/Mjolnir.app:
	curl -fsSL https://github.com/sdegutis/mjolnir/releases/download/0.4.3/Mjolnir-0.4.3.tgz -o mjolnir.tgz
	tar xf mjolnir.tgz -C /Applications
	open $@
	rm -f mjolnir.tgz

always:
	true

