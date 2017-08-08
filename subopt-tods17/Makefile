# Makefile for running a TeX document
# works on Linux
# usage:  assume the file is called name.tex; stem is "name"
#	make FILE=name
#

# define suffix rules: get .dvi from .tex files; get .ps from .dvi files
.SUFFIXES: .tex .dvi .ps .pdf

BIBTEXREFS = 

STYLEFILES = citesort.sty  simplemargins.sty 

TEXFILES = paper.tex 
EPSFILES = figures/*.eps 

# generate the Postscript file from the .dvi file
# (review .ps using ghostscript)

.dvi.ps: 
	dvips $< -o $*.ps

.ps.pdf:
	ps2pdf $<

FILE = paper
PS = $(FILE).ps
DVI = $(FILE).dvi
BBLFILE = $(FILE).bbl
EXPENDABLES = *.dvi *.bbl *.ps *.log *.aux *.blg *BAK
TEX = pdflatex
ACRO = acroread

$(FILE).pdf : $(FILE).tex $(BBLFILE)
	$(TEX) $(FILE).tex
	$(TEX) $(FILE).tex

#$(FILE).ps  : $(FILE).dvi

ghost :
	ghostview $(PS) &

xdvi :
	xdvi $(DVI) &

# use TeX to generate the .dvi file from .tex source files
# run latex twice to get cross-references inserted correctly
# (review .dvi using xdvi)

#$(FILE).dvi: $(EPSFILES) $(TEXFILES) $(BBLFILE) $(STYLEFILES)
#	$(TEX) $(FILE)
#	$(TEX) $(FILE)

$(BBLFILE) : $(TEXFILES) $(BIBTEXREFS) 
	$(TEX) $(FILE)
	bibtex $(FILE)
	$(TEX) $(FILE)

# "make clean" will remove everything that can be regenerated
clean:
	/bin/rm -f $(EXPENDABLES)

realclean:
	/bin/rm -f $(EXPENDABLES) $(BBLFILE) $(FILE).toc

# "make all" will rebuild everything from scratch
all: clean
	make $(PS)
