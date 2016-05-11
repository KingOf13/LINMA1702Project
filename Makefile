all: *tex
	@pdflatex *.tex
	@pdflatex *.tex
	@rm *.aux -f
	@rm *.out -f
	@rm *.log -f
	@rm *.toc -f
