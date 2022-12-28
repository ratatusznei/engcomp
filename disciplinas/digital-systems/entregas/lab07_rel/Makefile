open: main.pdf
	evince main.pdf

main.pdf: main.tex
	R --vanilla -q -e "tinytex::latexmk('main.tex')"

.PHONY: clean
clean:
	rm -f main.pdf
