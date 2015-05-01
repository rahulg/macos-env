#!/bin/bash
set -e -u

fonts=(
	source-sans-pro/archive/2.010R-ro/1.065R-it.tar.gz
	source-serif-pro/archive/1.017R.tar.gz
	source-code-pro/archive/1.017R.tar.gz
)

for font in "${fonts[@]}"; do
	filename=$(basename $font)
	font_name=$(echo ${font} | sed -E 's#(.*)/archive.*#\1#')
	url=https://github.com/adobe-fonts/${font}
	echo -n "Downloading ${font_name}… "
	curl -fsSL ${url} -o ${filename}
	echo 'done'
	tar xf ${filename}
	rm ${filename}
done
