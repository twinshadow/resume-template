#!/bin/sh

#  ____                           _
# / ___| ___ _ __   ___ _ __ __ _| |_ ___  _ __ ___
#| |  _ / _ \ '_ \ / _ \ '__/ _` | __/ _ \| '__/ __|
#| |_| |  __/ | | |  __/ | | (_| | || (_) | |  \__ \
# \____|\___|_| |_|\___|_|  \__,_|\__\___/|_|  |___/

make_dvi () {
  [ -e "$1" ] || make_tex
	echo "Generating the DVI file..."
	latex "$1"
}

make_pdf () {
  [ -e "$1" ] || make_tex
	echo "Generating the PDF file..."
	pdflatex "$1"
}

make_ps () {
  [ -e "$1" ] || make_dvi
	echo "Generating the PS file..."
	dvips "$1"
}

make_rtf () {
  [ -e "$1" ] || make_tex
	echo "Generating the RTF file..."
	latex2rtf "$1"
}

# _____                    _       _
#|_   _|__ _ __ ___  _ __ | | __ _| |_ ___  ___
#  | |/ _ \ '_ ` _ \| '_ \| |/ _` | __/ _ \/ __|
#  | |  __/ | | | | | |_) | | (_| | ||  __/\__ \
#  |_|\___|_| |_| |_| .__/|_|\__,_|\__\___||___/
#                   |_|

make_html () {
  echo "Rendering the HTML file..."
  tt-render --data="$RESUME" src/resume.html.tt2 > resume.html
}

make_tex () {
  echo "Rendering the TeX file..."
  tt-render --data="$RESUME" src/resume.tex.tt2 > resume.tex
}

make_txt () {
  echo "Rendering the Text file..."
  tt-render --data="$RESUME" src/resume.txt.tt2 | fold -s -w80 > resume.txt
}

make_clean () {
  echo "Cleaning the directory..."
  rm -fv *.aux *.dvi *.html *.log *.pdf *.ps *.rtf *.tex *.txt
}

make_all () {
  make_txt
  make_html
  make_pdf resume.tex
}

usage () {
  [ "$1" ] && echo "$1"
  echo "$0: Command [Command...]
  Commands:
    all		Generates the HTML, PDF, and TXT files
    clean		removes all generated files from the directory

    dvi
    html
    pdf
    ps
    rtf
    tex
    txt"

  [ "$1" ] && exit 1
  exit
}

# __  __       _
#|  \/  | __ _(_)_ __
#| |\/| |/ _` | | '_ \
#| |  | | (_| | | | | |
#|_|  |_|\__,_|_|_| |_|

RESUME="resume.yaml"
[ "$resume" ] && RESUME="$resume"
[ -e "$RESUME" ] || usage "___Resume file is missing___"
[ -z "$*" ] && usage
[ -e "$(which tt-render)" ] || usage "___Please install Template::Toolkit::Simple from CPAN___"
for cmd in $@; do
    make_$cmd
done
