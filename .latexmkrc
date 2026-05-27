# XeLaTeX + Skim PDF viewer тохиргоо
$pdf_mode = 5;   # xelatex → xdv → pdf (xdvipdfmx)
$xelatex = 'xelatex -synctex=1 -interaction=nonstopmode %O %S';
$biber = '/opt/homebrew/bin/biber %O %S';
$pdf_previewer = 'open -a Skim';
$clean_ext = 'synctex.gz synctex.gz(busy) aux bcf bbl blg fdb_latexmk fls log out run.xml toc lof lot xdv bcf-SAVE-ERROR bbl-SAVE-ERROR';
