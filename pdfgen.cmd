:: Manual Generation
::
::  Requirement
::      1. pandoc
::      2. fart : http://sourceforge.net/projects/fart-it/
::      3. kotex
set target=project

set title="Document Title"
set author="Document Author"
set team="Publisher Team"
set date="July 2013"
for /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
set currdate=%ldt:~0,4%-%ldt:~4,2%-%ldt:~6,2%
set revision="1"

set datetarget=%target%_%currdate%

:: docs   = $(wildcard doc/*.md)
:: result = $(patsubst %.cpp,$(OBJDIR)/%.o,$(SRCS))
set docs=   20130613_test.md      ^
            links.md 

cd doc

pandoc --latex-engine=xelatex                           ^
    -o %datetarget%.tex                                 ^
    --standalone                                        ^
    --toc --toc-depth=2                                 ^
    --number-sections                                   ^
    --template=../tpl/eunchan.latex                     ^
    -V title=%title%                                    ^
    -V author=%author%                                  ^
    -V team=%team%                                      ^
    -V date=%date%                                      ^
    -V revision=%revision%                              ^
    -V fontsize=10.5pt                                  ^
    -V papersize=letterpaper                            ^
    -V sides=oneside                                    ^
    -V documentclass=book                               ^
    %docs%  

pause

copy %datetarget%.tex %datetarget%.tex.bak

..\fart.exe -B --backup %datetarget%.tex {verbatim} {Verbatim}

xelatex %datetarget%.tex
xelatex %datetarget%.tex

move /Y %datetarget%.pdf ..
move /Y %datetarget%.tex ..

cd ..

del ./doc/%datetarget%.*

