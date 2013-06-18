#!/bin/sh

target=project

title="Document Title"
author="Document Author"
team="Publisher Team"
date="`LANG=en_US.utf-8 date +'%B %Y'`"
currdate="`date +%Y%m%d`"
revision="1"

datetarget=${target}_${currdate}

#docs   = $(wildcard doc/*.md)
#result = $(patsubst %.cpp,$(OBJDIR)/%.o,$(SRCS))
docs="20130613_test.md      \
      links.md"

cd doc
# Copy tpl/eunchan.tex to ~/.cabal/share/pandoc-X/data/templates
pandoc --latex-engine=xelatex                           \
    -o ${datetarget}.tex                                \
    --standalone                                        \
    --toc --toc-depth=2                                 \
    --number-sections                                   \
    --template=../tpl/eunchan.latex                     \
    -V title="${title}"                                 \
    -V author="${author}"                               \
    -V team="${team}"                                   \
    -V date="${date}"                                   \
    -V revision="${revision}"                           \
    -V fontsize=10.5pt                                  \
    -V papersize=letterpaper                            \
    -V sides=oneside                                    \
    -V documentclass=book                               \
    ${docs}
sed -i 's/{verbatim}/{Verbatim}/g' ${datetarget}.tex
xelatex ${datetarget}.tex
xelatex ${datetarget}.tex
rm -f ../${datetarget}.pdf ../${datetarget}.tex
mv ${datetarget}.pdf ..
mv ${datetarget}.tex ..

cd ..

rm -f ./doc/${target}_*.*

