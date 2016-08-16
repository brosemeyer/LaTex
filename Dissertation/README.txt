
The formatting document is msudoc.cls.  You basically have an outer TeX file (Tarr_phd.tex) that handles the setup, creating frontmatter, mainmatter, bibliography, etc, which in turn calls each individual chapter (Chapter1_intro, Chapter2_a_manuscript_chap, Chapter3_not_manuscript_chap, etc.).


There are just a few problems with the formatting, which need to be fixed by hand:

1) The primary one is that if you have multiple pages for \tableofcontents, \listoftables, or \listoffigures, then you do not get headings like "LIST OF FIGURES -- CONTINUED" on the 2nd, 3rd, etc pages.  But this is fixable.  

First, don't care about it until you submit.  

When you do submit, you just have to uncomment/comment/add a couple appropriate lines in the correct files.  In the outer file, Tarr_phd.tex, at line 52 you will find the command "\nofiles".  COMMENT OUT THIS COMMAND UNTIL YOU WANT A FINAL VERSION.  \nofiles means that latex will not update auxiliary files (.bbl, .toc, .lot, etc...) when it compiles.  So, when you want to create a final version, uncomment that line.  Open up the pdf of your disseration, and check out the Table of Contents page (list of figures page, list of tables page...).  If it spills over onto multiple pages, find where the page break is.  Open up the appropriate file (eg, Tarr_phd.toc for Table of Contents) and simply insert the following line at the location of the page break:
\par \par \vfil \penalty -\@M \write \m@ne {}\vbox {}\penalty -\@Mi \par \hskip 1em\relax \hfill TABLE OF CONTENTS -- CONTINUED \hfill \hskip 1em\relax \hskip 1em\relax \vspace {.2in} \hskip 1em\relax \par 

For List of Figures and List of Tables, you'll need something like the following:
\par \par \vfil \penalty -\@M \write \m@ne {}\vbox {}\penalty -\@Mi \par \hskip 1em\relax \hfill LIST OF FIGURES -- CONTINUED \hfill \hskip 1em\relax \hskip 1em\relax \vspace {.2in} \hskip 1em\relax \par
\noindent
  {Figure}\hfill{Page}
  \par
  \vspace{7.5\p@}

Which just adds the words "Figure" and "Page" to the appropriate spots in the list of figures.


2) For manuscript style dissertations, the beginning of each manuscript chapter needs to have Manuscript Authors and Manuscript Info pages.  See Chapter_manuscript_example.tex for an example.  The simple outline that is added to the beginning of each manuscript_chapter.tex file is:

<<BEGINNING OF MANUSCRIPT_CHAPTER.TEX >>
\chapter{Here's your title}\label{ch:chX_label}
\begin{manuscriptauths}
	blah 
	blah
	blah
\end{manuscriptauths}
\pagebreak
\begin{manuscriptinfo}
	blah
	blah
	blah
	\makebox[0pt]{\hspace{-2em}x} <<PUT THE "x" ON THE APPROPRIATE LINE>>
\end{manuscriptinfo}
THE REST OF YOUR CHAPTER:
\begin{abstract}
blah blah blah
\end{abstract}
blah blah blah blah etc...
<<END OF MANUSCRIPT_CHAPTER.TEX >>


3) Approval page: on line 680 and following of msudoc.cls, you'll have to comment/uncomment the correct lines (eg, "\@chairone \\" vs "\@signatureline{\@chairone} \\ ") for the version that goes to the dept and publisher and the one that goes to the school.


I believe I got everything else working correctly.

Best,
Lucas Tarr
Sept 16th, 2013.
