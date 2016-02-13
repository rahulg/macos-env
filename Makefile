.NOTPARALLEL:
.PHONY: all fonts mjolnir terminfo brewtstrap always clean

MJOLNIR_APP=/Applications/Mjolnir.app
KEYBINDINGS=~/Library/KeyBindings/DefaultKeyBinding.dict
FONTS=source-sans-pro/archive/2.020R-ro/1.075R-it.tar.gz \
      source-serif-pro/archive/1.017R.tar.gz \
      source-code-pro/archive/2.010R-ro/1.030R-it.tar.gz
TERMINFOS=$(wildcard terminfos/*)
ROCKS=mjolnir.hotkey \
	  mjolnir.application \
	  mjolnir.fnutils \
	  mjolnir.geometry \
	  mjolnir.screen \
	  mjolnir.keycodes

ifeq ($(shell uname),Darwin)
	TARGETS+= fonts mjolnir terminfo brewtstrap $(KEYBINDINGS)
endif

all: $(TARGETS)

fonts: $(FONTS)

terminfo: $(TERMINFOS)

%.tar.gz:
	$(eval FONTNAME := $(shell echo $@ | sed -E 's#(.*)/archive.*#\1#'))
	mkdir -p $(FONTNAME)
	curl -fsSL https://github.com/adobe-fonts/$@ -o $(FONTNAME).tar.gz
	tar xf $(FONTNAME).tar.gz -C $(FONTNAME)
	rm $(FONTNAME).tar.gz
	find $(FONTNAME) -name '*.otf' -print0 | xargs -0 open

mjolnir: $(MJOLNIR_APP) lua $(ROCKS)
	cp -rv .mjolnir $(HOME)

lua:
	brew install lua

mjolnir.%: always
	luarocks-5.2 install $@

$(MJOLNIR_APP):
	curl -fsSL https://github.com/sdegutis/mjolnir/releases/download/0.4.3/Mjolnir-0.4.3.tgz -o mjolnir.tgz
	tar xf mjolnir.tgz -C /Applications
	open $@
	rm -f mjolnir.tgz

brewtstrap:
	bash ./brewtstrap

$(KEYBINDINGS): DefaultKeyBinding.dict
	mkdir -p ~/Library/KeyBindings/
	cp -v $(realpath $<) $@

%.tic: always
	sudo tic $@

always:
	@true

clean:
	rm -rf source-{sans,serif,code}-pro
