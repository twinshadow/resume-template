# Sources and objects
RESUME_DATA=	resume.yaml
OBJS_TEX=	resume.aux resume.dvi resume.ps resume.rtf resume.tex resume.log
OBJS=		resume.pdf resume.txt resume.html


# Program defaults
DVIPS?=		dvips
LATEX2RTF?=	latex2rtf
LATEX?=		latex
MKDIR?=		mkdir
PDFLATEX?=	pdflatex
PYTHON?=	python
RM?=		rm -f

# Templates
%.tex: %.tex.jinja
	${PYTHON} ${CURDIR}/render_jinja.py "${RESUME_DATA}" "$<" > "${@}"

%.txt: %.txt.jinja
	${PYTHON} ${CURDIR}/render_jinja.py "${RESUME_DATA}" "$<" > "${@}"

#	@tt-render --data="${RESUME_DATA}" "$^" | fold -s -w80 | sed '/  -/,/^$$/s/^\(\S\)/    \1/g; s/\s*$$//' > "$@"

%.html: %.html.jinja
	${PYTHON} ${CURDIR}/render_jinja.py "${RESUME_DATA}" "$<" > "${@}"


# Latex Renderers
%.pdf: %.tex
	${PDFLATEX} "$<"

%.rtf: %.tex
	${LATEX2RTF} "$<"

%.dvi: %.tex
	${LATEX} "$<"

%.ps: %.dvi
	${DVIPS} "$<"

# Targets
all: ${OBJS}

clean:
	${RM} ${OBJS} ${OBJS_TEX}

.PHONY: clean
