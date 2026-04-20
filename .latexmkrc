# Skim PDF viewer-тэй ажиллах latexmk тохиргоо
$pdf_mode = 1;
$pdflatex = 'xelatex -synctex=1 -interaction=nonstopmode %O %S';
$pdf_previewer = 'open -a Skim';
$clean_ext = 'synctex.gz synctex.gz(busy) aux bcf bbl blg fdb_latexmk fls log out run.xml toc lof lot';
