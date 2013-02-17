RESUME_DATA=resume.yaml

# Templates
%.tex: src/%.tex.tt2
	@echo "Rendering the TeX file..."
	@tt-render --data="${RESUME_DATA}" "$^" > "$@"

%.txt: src/%.txt.tt2
	@echo "Rendering the Text file..."
	@tt-render --data="${RESUME_DATA}" "$^" | fold -s -w80 | sed '/  -/,/^$$/s/^\(\S\)/    \1/g; s/\s*$$//' > "$@"

%.html: src/%.html.tt2
	@echo "Rendering the HTML file..."
	@tt-render --data="${RESUME_DATA}" "$^" > "$@"

# Latex Renderers
%.pdf: %.tex
	@echo "Generating the PDF file..."
	pdflatex "$^"

%.rtf: %.tex
	@echo "Generating the RTF file..."
	latex2rtf "$^"

%.dvi: %.tex
	@echo "Generating the DVI file..."
	latex "$^"

%.ps: %.dvi
	@echo "Generating the PS file..."
	dvips "$^"

all: resume.pdf resume.html resume.txt

clean:
	rm -fv *.aux *.dvi *.html *.log *.pdf *.ps *.rtf *.tex *.txt
