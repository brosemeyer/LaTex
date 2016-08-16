% This version last updated July 2013.
%   
% Known issues:
%   Multi-page ToC, LoF, LoT do not have headings (ex: Table of Contents -- Continued)
%   hyperref package doesn't work

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{msudoc}[2013/07/14 v1.4 beta MSU document class]
\RequirePackage[normalem]{ulem}
\newif\if@mainmatter \@mainmattertrue
\newif\if@dissertation \@dissertationtrue
\newif\if@beforetoc \@beforetoctrue
\newif\if@oneeqnum \@oneeqnumfalse
\newif\if@onethmnum \@onethmnumfalse
\DeclareOption{dissertation}{
  \gdef\@doctype{dissertation}
  \@dissertationtrue}
\DeclareOption{thesis}{
  \gdef\@doctype{thesis}
  \@dissertationfalse}
\DeclareOption{paper}{
  \gdef\@doctype{paper}
  \@dissertationfalse}
\DeclareOption{draft}{\setlength{\overfullrule}{5\p@}}
\DeclareOption{final}{\setlength{\overfullrule}{\z@}}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\ExecuteOptions{final,dissertation}
\ProcessOptions
\setlength{\paperheight}{11in}
\setlength{\paperwidth}{8.5in}
\input{bk12.clo}
%  ********************************-**********************************
%  *                          PAGE STYLES                            *
%  ********************************-**********************************
\renewcommand{\ps@plain}{
  \def\@oddhead{\hfil\thepage\hfil}
  \def\@oddfoot{}
  \def\@evenhead{\hfil\thepage\hfil}
  \def\@evenfoot{}}
%  ********************************-**********************************
%  *                          PAGE LAYOUT                            *
%  ********************************-**********************************
%
% SIDE MARGINS
%
\setlength{\oddsidemargin}{.5in}
\setlength{\evensidemargin}{.5in}
%
% VERTICAL SPACING
%
%\setlength{\topmargin}{1.0in}
\setlength{\topmargin}{\z@}
\setlength{\headheight}{2ex}
%\setlength{\headsep}{15\p@} % the original one
%\setlength{\headsep}{21pt}
\setlength{\headsep}{21pt}
%\setlength{\footskip}{30\p@}
\let\tableline=\hline
\newcommand\subacknowledgments{\vskip 3ex\@plus.8ex\@minus.4ex}%
\let\subacknowledgements=\subacknowledgments
\setlength\smallskipamount{3\p@\@plus1\p@\@minus1\p@}%
\setlength\medskipamount{6\p@\@plus2\p@\@minus2\p@}%
\setlength\bigskipamount{12\p@\@plus4\p@\@minus4\p@}%
%
% TEXT DIMENSION
%
\setlength{\textheight}{8.75in}
\setlength{\textwidth}{6in}
\setlength{\columnsep}{10\p@}
\setlength{\columnseprule}{0\p@}
\setlength{\lineskip}{1\p@}
\setlength{\normallineskip}{1\p@}
\def\singlespace{\baselineskip=13.5pt}
%\def\doublespace{\baselineskip=21pt}
\@mparswitchfalse
%
%  ********************************-**********************************
%  *                          PARAGRAPHING                           *
%  ********************************-********************************** 
\setlength{\parskip}{\z@ \@plus \p@ \@minus \p@}
\setlength{\parindent}{.7cm}          %Width of paragraph indentation.
%
% PAGE BREAKING PENALTIES
%
\@lowpenalty   51 %Produced by \nopagebreak[1] or \nolinebreak[1]
\@medpenalty  151 %Produced by \nopagebreak[2] or \nolinebreak[2]
\@highpenalty 301 %Produced by \nopagebreak[3] or \nolinebreak[3]
\@beginparpenalty -\@lowpenalty %Before list or paragraph environment.
\@endparpenalty   -\@lowpenalty %After list or paragraph environment.
\@itempenalty     -\@lowpenalty %Between list items.
\clubpenalty \@M     % Club line at bottom of page.
\widowpenalty \@M    % Widow line at top of page.
%\displaywidowpenalty % Math display widow line.
%\predisplaypenalty   % Breaking before a math display.
%\postdisplaypenalty  % Breaking after a math display.
%\interlinepenalty    % Breaking at a line within a paragraph.
\brokenpenalty \@M    % Breaking after a hyphenated line.
%  ********************************-**********************************
%  *         CHAPTERS, SECTIONS, SUBSECTIONS, SUBSUBSECTIONS         * 
%  ********************************-**********************************
%
% CHAPTERS
%
\newlength{\chapterheadskip}
\newcounter{chapter}
\newcommand{\chapternumber}{\arabic{chapter}.\space}
\renewcommand{\thechapter}{\@arabic\c@chapter}
\newcommand{\chapter}{
  \clearpage
  \global\@topnum\z@
  \@ifstar{\@starchapter}{\@chapter}}
\def\@chapter#1{
  \if@mainmatter
    \refstepcounter{chapter}
    \typeout{\chaptername\space\thechapter.}
    \addcontentsline{toc}{chapter}{\protect\numberline{\thechapter}\uppercase{#1}} % uppercase
  \else
    \typeout{#1}
    \addcontentsline{toc}{chapter}{\uppercase{#1}}
  \fi
  \@makechapterhead{\chapternumber#1}}
\def\@starchapter#1{
  \typeout{#1}
  \@makechapterhead{\uppercase{#1}}}
\def\@makechapterhead#1{
  \par
%  \vspace*{\chapterheadskip}
  \begingroup
    \normalsize\centering
    \if@mainmatter
%      \chaptername\space\thechapter
%      \par\nobreak
%      \vspace{30\p@}
    \fi
    \interlinepenalty\@M 
    \uppercase{#1}  % chapter titles in uppercase
    \par\nobreak
    \addvspace{15\p@}
  \endgroup}
%
% SECTIONS
%
\newcounter{sectionA}[chapter]
\newcommand{\sectionAnumber}{\arabic{sectionA} }
\renewcommand{\thesectionA}{\thechapter.\@arabic\c@sectionA}
\newcommand{\section}[1]{
  \if@mainmatter
  \refstepcounter{sectionA}
  \par
  \addvspace{30\p@}
  \typeout{\sectionname\space\thesectionA.}
  \addcontentsline{toc}{section}{\protect\numberline{\thesectionA}#1}
  \begingroup
    \normalsize\centering
    \interlinepenalty \@M
    \settowidth{\@tempdima}{#1}
    \ifdim\@tempdima<\textwidth
    \uline{\thesectionA.\space#1} 
	
    \else
      \ifdim\@tempdima<2\textwidth
        \uline{\parbox[b]{.51\@tempdima}{\centering{\thesectionA.\space#1}}} 
      \else
        \uline{\parbox[b]{.34\@tempdima}{\centering{#1}}}
      \fi
    \fi
    \par\nobreak
    \addvspace{15\p@}
  \endgroup
  \else
   \par
  \addvspace{30\p@}
  %\addcontentsline{toc}{section}{#1}
  \begingroup
    \normalsize\centering
    \interlinepenalty \@M
    \settowidth{\@tempdima}{#1}
    \ifdim\@tempdima<\textwidth
    \uline{#1} 
    \else
      \ifdim\@tempdima<2\textwidth
        \uline{\parbox[b]{.51\@tempdima}{\centering{#1}}} 
      \else
        \uline{\parbox[b]{.34\@tempdima}{\centering{#1}}}
      \fi
    \fi
    \par\nobreak
    \addvspace{15\p@}
  \endgroup
  
  \fi
  }
%
% SUBSECTIONS
%
\newcounter{subsectionA}[sectionA]
\newcommand{\subsectionAnumber}{\arabic{subsectionA} }
\renewcommand{\thesubsectionA}{\thesectionA.\@arabic\c@subsectionA}
\newcommand{\subsection}[1]{
  \refstepcounter{subsectionA}
  \par
  \addvspace{30\p@}
  \addcontentsline{toc}{subsection}{\protect\numberline{\thesubsectionA}#1}
  \begingroup
    \normalsize
    \settowidth{\@tempdima}{#1}
    \ifdim\@tempdima<.5\textwidth
      \noindent\uline{\thesubsectionA.\space#1}
    \else
      \noindent\uline{\parbox[b]{.5\textwidth}{\thesubsectionA.\space#1}}
    \fi
    \par\nobreak
  \endgroup}
%
% SUBSUBSECTIONS
%
\newcommand{\subsubsection}[1]{
  \par
  \addvspace{15\p@}
  \addcontentsline{toc}{subsubsection}{#1}
  \uline{#1}.}
%  ********************************-**********************************
%  *                      FIGURES AND TABLES                         *
%  ********************************-**********************************
\def\@addtocurcol{
  \@insertfalse
  \@setfloattypecounts
  \ifnum \@fpstype=8
  \else
    \ifnum \@fpstype=24
    \else
      \@flsettextmin
      \advance \@textmin \@textfloatsheight
      \@reqcolroom \@pageht
      \ifdim \@textmin>\@reqcolroom
        \@reqcolroom \@textmin
      \fi
      \advance \@reqcolroom \ht\@currbox
      \ifdim \@colroom>\@reqcolroom
        \@flsetnum \@colnum
        \ifnum \@colnum>\z@
          \@bitor\@currtype\@deferlist
          \if@test
          \else
            \@bitor\@currtype\@botlist
            \if@test
              \@addtobot
            \else
              \ifodd \count\@currbox
                \advance \@reqcolroom \intextsep
                \advance \@reqcolroom 15\p@ %JLJ 
                \ifdim \@colroom>\@reqcolroom
                  \global \advance \@colnum \m@ne
                  \global \advance \@textfloatsheight \ht\@currbox
                  \global \advance \@textfloatsheight 2\intextsep
                  \global \advance \@textfloatsheight 15\p@ %JLJ
                  \@cons \@midlist \@currbox
                  \if@nobreak
                    \nobreak
                    \@nobreakfalse
                    \everypar{}
                  \else
                    \addpenalty \interlinepenalty
                  \fi
                  \vskip 15\p@ %JLJ
                  \vskip \intextsep
                  \box\@currbox
                  \penalty\interlinepenalty
                  \vskip\intextsep
                  \ifnum\outputpenalty <-\@Mii \vskip -\parskip\fi
                  \outputpenalty \z@
                  \@inserttrue
                \fi
              \fi
              \if@insert
              \else
                \@addtotoporbot
              \fi
            \fi
          \fi
        \fi
      \fi
    \fi
  \fi
  \if@insert
  \else
    \@resethfps
    \@cons\@deferlist\@currbox
  \fi}
%
% Float Placement Parameters
%
\setlength{\floatsep}{30\p@ \@plus \p@ \@minus \p@}
\setlength{\textfloatsep}{30\p@ \@plus \p@ \@minus \p@}
\setlength{\intextsep}{15\p@ \@plus \p@ \@minus \p@}
\setlength{\dblfloatsep}{30\p@ \@plus \p@ \@minus \p@}
\setlength{\dbltextfloatsep}{30\p@ \@plus \p@ \@minus \p@}
\setcounter{topnumber}{5}
\renewcommand{\topfraction}{.85}
\setcounter{bottomnumber}{5}
\renewcommand{\bottomfraction}{.7}
\setcounter{totalnumber}{10}
\renewcommand{\textfraction}{.15}
\renewcommand{\floatpagefraction}{.66}
\setcounter{dbltopnumber}{5}
\renewcommand{\dbltopfraction}{.66}
\renewcommand{\dblfloatpagefraction}{.66}
%
% FIGURES
%
\newcounter{figure}
\renewcommand{\thefigure}{\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\newenvironment{figure}{
  \@float{figure}}
{\end@float}
\newenvironment{figure*}{
  \@dblfloat{figure}}
{\end@dblfloat}
%
% TABLES
%
\newcounter{table}
\renewcommand{\thetable}{\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\newenvironment{table}{
  \@float{table}}
{\end@float}
\newenvironment{table*}{
  \@dblfloat{table}}
{\end@dblfloat}
%% ALSO ADD TABLECOMMENTS COMMAND
\def\@provide#1{%Implicit #2
 \@ifxundefined#1{\def#1}{\def\@tempa}%
}%
\def\prepdef#1#2{%
 \@ifxundefined#1{\toks@{}}{\toks@\expandafter{#1}}%
 \toks@ii{#2}%
 \edef#1{\the\toks@ii\the\toks@}%
}%
\def\appdef#1#2{%
 \@ifxundefined#1{\toks@{}}{\toks@\expandafter{#1}}%
 \toks@ii{#2}%
 \edef#1{\the\toks@\the\toks@ii}%
}%
\def\appgdef#1#2{%
 \@ifxundefined#1{\toks@{}}{\toks@\expandafter{#1}}%
 \toks@ii{#2}%
 \xdef#1{\the\toks@\the\toks@ii}%
}%
\toksdef\toks@ii=\tw@
\newskip\tnotemarkskip
\tnotemarkskip7pt
\newdimen\@abovenoteskip%
\newbox\spew@tblnotesbox%
\newbox\restof@tblnotesbox%
\global\newdimen\noteheight%
\global\newdimen\pt@tabnoteminht%
\global\pt@tabnoteminht=0pt%
\global\advance\pt@tabnoteminht-\@abovenoteskip
\global\@abovenoteskip=0pt
\newcommand\tablecomments[1]{\ifdim\@abovenoteskip=0pt\global\@abovenoteskip=10pt\fi
\appgdef\tblnote@list{\hsize\pt@width\leftskip\z@\rightskip\z@%
\@tablecom{\parfillskip\z@ plus1fil#1\endgraf}}}%
\def\@tablecom#1{%
 \par
 \vspace*{3ex}%
 {%\parbox{\pt@width} %%%
{\hskip1em\rmfamily Note. --- #1}\par}%
}%
\def\@tableref@pptt#1{%
 \par
 \vspace*{3ex}%
 {%\parbox{\pt@width} %%%
 {\hskip1em{\sc References.---}#1}\par}%
}%
\def\@tablecom@pptt#1{%
 \vspace*{3ex}{%
  %\parbox{\pt@width} %%%
  {\hskip1em{\sc Note.---}#1}\par}%
}
%
% CAPTIONS
%
\newlength{\abovecaptionskip}
\newlength{\belowcaptionskip}
\setlength{\abovecaptionskip}{15\p@}
\setlength{\belowcaptionskip}{0\p@}
\long\def\@makecaption#1#2{
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1. #2.}
  \ifdim \wd\@tempboxa >\hsize
    #1. #2.\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}
  \fi
  \vskip\belowcaptionskip}
\setcounter{secnumdepth}{0}
\newcommand{\frontmatter}{
  \typeout{FRONT MATTER}
  \clearpage
  \@mainmatterfalse
  \pagenumbering{roman}}
\newcommand{\mainmatter}{
  \typeout{MAIN MATTER}
  \setlength{\chapterheadskip}{.125cm}
  \clearpage
  \@mainmattertrue
  \pagenumbering{arabic}}
\newcommand{\backmatter}{
  \typeout{BACK MATTER}
  \clearpage
  \@mainmatterfalse}
%  ********************************-**********************************
%  *                             LISTS                               *
%  ********************************-**********************************
\setlength{\leftmargini}{2.5em}
\setlength{\leftmargin}{\leftmargini}
\setlength{\leftmarginii}{2.2em}
\setlength{\leftmarginiii}{1.87em}
\setlength{\leftmarginiv}{1.7em}
\setlength{\leftmarginv}{1em}
\setlength{\leftmarginvi}{1em}
\setlength{\labelsep}{.5em}
\setlength{\labelwidth}{\leftmargini}
\addtolength{\labelwidth}{-\labelsep}
\setlength{\parsep}{\z@}
\setlength{\partopsep}{\z@}
%
% ENUMERATIONS
%
\renewcommand{\theenumi}{\@arabic\c@enumi}
\renewcommand{\theenumii}{\@alph\c@enumii}
\renewcommand{\theenumiii}{\@roman\c@enumiii}
\renewcommand{\theenumiv}{\@Alph\c@enumiv}
\newcommand{\labelenumi}{\theenumi.}
\newcommand{\labelenumii}{(\theenumii)}
\newcommand{\labelenumiii}{\theenumiii.}
\newcommand{\labelenumiv}{\theenumiv.}
\renewcommand{\p@enumii}{\theenumi}
\renewcommand{\p@enumiii}{\theenumi(\theenumii)}
\renewcommand{\p@enumiv}{\p@enumiii\theenumiii}
%
% ITEMIZATION
%
\newcommand{\labelitemi}{\textbullet}
\newcommand{\labelitemii}{\normalfont\bfseries \textendash}
\newcommand{\labelitemiii}{\textasteriskcentered}
\newcommand{\labelitemiv}{\textperiodcentered}
\def\itemize{
  \ifnum \@itemdepth >\thr@@\@toodeep\else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}
    \expandafter
    \list
      \csname\@itemitem\endcsname
      {\def\makelabel##1{\hss\llap{##1}}
      \itemsep=0pt 
      \parsep=0pt 
      \topsep=0pt
      \parskip=0pt
      \partopsep=0pt}
  \fi}
\let\enditemize =\endlist
%
% DESCRIPTIONS
%
\newenvironment{description}{
  \list{}{
    \labelwidth\z@ \itemindent-\leftmargin
    \let\makelabel\descriptionlabel}}
 {\endlist}
\newcommand*{\descriptionlabel}[1]{
  \hspace\labelsep \normalfont\bfseries #1}
%
% VERSES
%
\newenvironment{verse}{
  \let\\\@centercr
  \list{}{
    \setlength{\itemsep}{\z@}
    \setlength{\itemindent}{-1.5em}
    \setlength{\listparindent}{\itemindent}
    \setlength{\rightmargin}{\leftmargin}
    \advance\leftmargin 1.5em}
  \item\relax}
{\endlist}
%
% QUOTATIONS
%
\newenvironment{quotation}{
%  \list{}{
%    \listparindent 1.5em
%    \itemindent \listparindent
%    \rightmargin \leftmargin
%    \parsep\z@\@plus\p@}
%  \item\relax}
%  {\endlist}
  \par
  \addvspace{15\p@}
  \normalsize
  \begin{list}{}{
    \setlength{\topsep}{\z@}
    \setlength{\listparindent}{\parindent}
    \setlength{\itemindent}{\listparindent}
    \setlength{\leftmargin}{\listparindent}
    \setlength{\rightmargin}{\leftmargin}
    \setlength{\parsep}{\z@}}
  \item\relax}
  {\end{list}}
%
% QUOTES
%
\newenvironment{quote}{
%  \list{}{
%    \rightmargin\leftmargin}
%  \item\relax}
%{\endlist}
  \par
  \addvspace{15\p@}
  \normalsize
  \begin{list}{}{
    \setlength{\topsep}{\z@}
    \setlength{\leftmargin}{\parindent}
    \setlength{\rightmargin}{\leftmargin}
    \setlength{\parsep}{15\p@}}
  \item\relax}
  {\end{list}}
%
% APPENDIX
%
\newcounter{appendix}
\renewcommand{\theappendix}{\@Alph\c@appendix}
\newcommand{\appendix}[1]{
  \newpage
  \vspace*{9cm}
  \refstepcounter{appendix}
  \addcontentsline{toc}{chapterA}
     {\appendixname\space\theappendix\space--\space#1}
  \begingroup
    \normalsize\centering
    \underline{\appendixname\space\theappendix}
    \par\vspace{30pt}
    #1
    \par
  \endgroup
  \newpage}
\newcommand{\divisionpage}[1]{
  \newpage
  \vspace*{9cm}
  \addcontentsline{toc}{chapterA}{#1}
  \begingroup
    \normalsize\centering
    #1
    \par
  \endgroup
  \newpage}
\setlength{\arraycolsep}{5\p@}
\setlength{\tabcolsep}{6\p@}
\setlength{\arrayrulewidth}{.4\p@}
\setlength{\doublerulesep}{2\p@}
\setlength{\tabbingsep}{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength{\fboxsep}{3\p@}
\setlength\fboxrule{.4\p@}
\@addtoreset {equation}{chapter}
\renewcommand{\theequation}{
  \ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@equation}
%  ********************************-**********************************
%  *                          TITLE PAGE                             *
%  ********************************-**********************************
\newcounter{titlelines}
\setcounter{titlelines}{0}
\renewcommand{\title}[1]{
  \ifcase\value{titlelines}
    \def\@titleone{\uppercase{#1}} \or \def\@titletwo{\uppercase{#1}} \or \def\@titlethree{\uppercase{#1}}
  \else
    \typeout{Too many title lines.}
  \fi
  \addtocounter{titlelines}{1}}
\newcommand{\maketitlepage}{
  \thispagestyle{empty}
  \begin{center}
  \ifnum\c@titlelines>2
    \vspace*{1.0cm}
    \@titleone\par
    \@titletwo\par
    \@titlethree\par
  \else\ifnum\c@titlelines>1
    \vspace*{2.9cm}
    \@titleone\par
    \@titletwo\par
  \else\ifnum\c@titlelines>0
    \vspace*{3.9cm}
    \@titleone\par
  \else\typeout{No title.}
  \fi\fi\fi
  \vskip .9cm
  by\par
  \@author\\[2.2cm]
  \begingroup
    \normalsize
    A \@doctype\ submitted in partial fulfillment\\
    of the requirements for the degree\\
  \endgroup
  of\par
  \@degree\par
  in\par
  \@department\par
  \vskip 1.8cm
  \begingroup
    \normalsize
    MONTANA STATE UNIVERSITY\\
    Bozeman, Montana\\
  \endgroup
  \vskip 15pt
  \@submissiondate\\
  \end{center}
  \newpage}
%  ********************************-**********************************
%  *                        COPYRIGHT PAGE                           *
%  ********************************-**********************************
\newcommand{\makecopyrightpage}{
  \thispagestyle{empty}
  \clearpage
  \null\vfill
  \begingroup
    \interlinepenalty \@M
    \normalfont\centering
    \vspace{-.25\textheight}
    \includegraphics[height=10pt]{cc} COPYRIGHT\par
    by\par
    \@author\par
    \@copyrightyear\par
    Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License\par 
    \vfill\newpage
  \endgroup}
%  ********************************-**********************************
%  *                        APPROVAL PAGE                            *
%  ********************************-**********************************
\newcounter{chairs}
\setcounter{chairs}{0}
\newcommand{\chair}[1]{
  \ifcase\value{chairs}
    \def\@chairone{#1} \or \def\@chairtwo{#1} 
  \else
    \typeout{Too many committee co-chairs.}
  \fi
  \addtocounter{chairs}{1}}
\newcommand{\@signatureline}[1]{
  #1    & \underline{\hspace{6cm}} & \underline{\hspace{2cm}}\\
  \hfil & (Signature)              & \hspace{2cm} Date\\[30pt]}
\newcommand{\makeapprovalpage}{
  \chapterheadskip .125cm
  \chapter*{Approval}
 \addtocounter{page}{-1}
  \begin{center}
  of a \@doctype\ submitted by\\[15pt]
  \@author\par
  \vskip 30pt
  \end{center}
  \begingroup \normalsize \par
  This \@doctype\ has been read by each member of the \@doctype\ 
  committee and has been found to be satisfactory regarding content,
  English usage, format, citations, bibliographic style, and
  consistency, and is ready for submission to The Graduate
  School.\par
  \vskip 30pt
  \begin{center}
  
  \vspace{11pt}
  \@chairone \\ %use this line for final ETD
%  \@signatureline{\@chairone} \\ %use this line to get signature lines
  \vspace{11pt}
  \ \\
  
  Approved for the Department of \@department \\
  \ \\
  \vspace{11pt}
  \@head \\ %use this line for final ETD
  %\@signatureline{\@head} \\ %use this line to get signature lines
  \vspace{11pt}
  \ \\
  Approved for The Graduate School \\
  \ \\
  \vspace{11pt}
  \@dean \\ %use this line for final ETD
  %\@signatureline{\@dean}\\ %use this line to get signature lines
  
  \end{center}
  \endgroup}
%  ********************************-**********************************
%  *                       PERMISSION PAGE                           *
%  ********************************-**********************************
\newcommand{\makepermissionpage}{
  \chapterheadskip .125cm
  \chapter*{Statement of Permission to Use}
    In presenting this dissertation in partial fulfillment of the
    requirements for a doctoral degree at Montana State University, I
    agree that the Library shall make it available to borrowers under
    rules of the Library. \par
    This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike
    3.0 Unported License.  Anyone may copy, distribute, transmit, or alter this work under the
    following conditions: one must attribute the work to the author; one must not use this work for
    commercial purposes; if this work is altered or transformed, one must distribute the resultant
    product under this or a similar license.  To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/
 %   \href{http://creativecommons.org/licenses/by-nc-sa/3.0/}{http://creativecommons.org/licenses/by-nc-sa/3.0/}.
  \par
  \vskip 15pt
  \noindent
  \@author\\
  \@submissiondate\\
  }
%  ********************************-**********************************
%  *       TABLE OF CONTENTS, LIST OF FIGURES, LIST OF TABLES        *
%  ********************************-**********************************
\newlength{\@pnumwidth}
\newlength{\@cnumwidth}
\newlength{\@tocrmarg}
\setlength{\@pnumwidth}{.4cm} % width of the page numbers on RHS of TOC
\setlength{\@cnumwidth}{.6cm} % width of the chapter numbers on LHS of TOC
\setlength{\@tocrmarg}{2.5cm} % right margin break for multi-line chapter titles
\newcommand{\@dotsep}{2}
\setcounter{tocdepth}{3}
\renewcommand{\numberline}[1]{\hb@xt@\@tempdima{#1.\hfil}}

%
% TABLE OF CONTENTS
% 
\def\@dottedtocline#1#2#3#4#5{
  \ifnum #1>\c@tocdepth \else
    \vskip \z@ \@plus.2\p@
    {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
     \parindent #2\relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #3\relax
     \@tempdimb #3\relax
%     \addtolength{\@tempdimb}{1.9em} % controls indent for multi-line headings
     \advance\leftskip \@tempdimb \null\nobreak\hskip -\leftskip
     {#4}\nobreak
     \leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
        mu$}\hfill
     \nobreak
     \hb@xt@\@pnumwidth{\hfill\normalfont \normalcolor #5}
     \par}
  \fi}
  
\newcommand{\maketableofcontents}{
  \chapterheadskip .125cm
  \chapter*{\contentsname}
%\pagestyle{myheadings}
%TABLE OF CONTENTS -- CONTINUED
\markboth{TABLE OF CONTENTS -- CONTINUED}{}
  \vspace{7.5\p@}
  \begingroup
    \sloppy
    \normalsize
    \@starttoc{toc}
  \endgroup
  }
\newcommand*{\l@chapter}[2]{
  \addpenalty{-\@highpenalty}
  \vspace{7.5\p@}
  \@dottedtocline{0}{\z@}{\@cnumwidth}{#1}{#2}
  \penalty\@highpenalty
  \vspace{7.5\p@}}
\newcommand*{\l@chapterA}[2]{
  \addpenalty{-\@highpenalty}
  \vspace{0.0\p@}
  \@dottedtocline{0}{\z@}{\@cnumwidth}{#1}{#2}
  \penalty\@highpenalty
  \vspace{0.0\p@}}
\newcommand*{\l@section}{\@dottedtocline{1}{\@cnumwidth}{1.2\@cnumwidth}}
\newcommand*{\l@subsection}{\@dottedtocline{2}{2\@cnumwidth}{1.7\@cnumwidth}}
\newcommand*{\l@subsubsection}{\@dottedtocline{3}{3\@cnumwidth}{\z@}}
%
% LIST OF FIGURES
%
\newcommand{\makelistoffigures}{
  \chapterheadskip .125cm
  \chapter*{\listfigurename}
  \noindent
  {Figure}\hfill{Page}
  \par
  \vspace{7.5\p@}
  \begingroup 
    \normalsize
    \sloppy
    \@starttoc{lof}
  \endgroup}
\newcommand*{\l@figure}[2]{
  \vspace{7.5\p@}
  \@dottedtocline{1}{\@cnumwidth}{\@cnumwidth}{#1}{#2}
  \vspace{7.5\p@}}
%
% LIST OF TABLES
%
\newcommand{\makelistoftables}{
  \chapterheadskip .125cm
  \chapter*{\listtablename}
  \noindent
  {Table}\hfill{Page}
  \par
  \vspace{7.5\p@}
  \begingroup
    \normalsize
    \sloppy
    \@starttoc{lot}
  \endgroup}
\let\l@table\l@figure

%  ********************************-**********************************
%  *                          DEDICATION                             *
%  ********************************-**********************************
\newenvironment{dedication}{
  \chapter*{Dedication}
  \normalsize
  \vskip 15\p@}
  {\par}
%  ********************************-**********************************
%  *                        MANUSCRIPT INFO                          *
%  ********************************-**********************************
\newenvironment{manuscriptinfo}{
  \addcontentsline{toc}{section}{Manuscript Information Page}
  \begin{center}
    \uline{Manuscript Information Page}
  \end{center}
  \normalsize
  \vskip 15\p@}
  {\par}
%  ********************************-**********************************
%  *                       MANUSCRIPT AUTHORS                        *
%  ********************************-**********************************
\newenvironment{manuscriptauths}{
  \addcontentsline{toc}{section}{Contribution of Authors and Co--Authors}
  \begin{center}
    \uline{Contribution of Authors and Co--Authors}
  \end{center}
  \normalsize
  \vskip 15\p@}
  {\par}
%  ********************************-**********************************
%  *                         ACKNOWLEDGEMENTS                        *
%  ********************************-**********************************
\newenvironment{acknowledgements}{
  \chapter*{Acknowledgements}}
  {\par}
%  ********************************-**********************************
%  *                         PREFACE                        *
%  ********************************-**********************************
\newenvironment{preface}{
  \chapter*{Preface}}
  {\par}

%  ********************************-**********************************
%  *                           CONVENTIONS                             *
%  ********************************-**********************************
\newenvironment{conventions}{
  \chapter*{Conventions}}
  {\par}
%  ********************************-**********************************
%  *                           ABSTRACT                              *
%  ********************************-**********************************
\newenvironment{abstract}{
  \chapter*{Abstract}
  \normalsize
  \vskip 15\p@}
  {\par}
%  ********************************-**********************************
%  *                          BIBLIOGRAPHY                           *
%  ********************************-**********************************
\newdimen{\bibindent}
\setlength{\bibindent}{1.5em}
\newenvironment{thebibliography}[1]{
  \chapterheadskip .125cm
  \vspace{\z@}
  \begingroup
    \normalsize
    \list{\@biblabel{\@arabic\c@enumiv}}
   {\settowidth\labelwidth{\@biblabel{#1}}
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
%
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep 10\p@
%
    \usecounter{enumiv}
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}}
    \sloppy
    \clubpenalty4000
    \@clubpenalty \clubpenalty
    \widowpenalty4000
    \sfcode`\.\@m}
   {\def\@noitemerr
   {\@latex@warning{Empty `thebibliography' environment}}
    \endlist
  \endgroup}
\newcommand{\newblock}{\hskip .11em\@plus.33em\@minus.07em}
%  ********************************-**********************************
%  *                             INDEX                               *
%  ********************************-**********************************
\newenvironment{theindex}{
  \setlength{\columnseprule}{\z@}
  \setlength{\columnsep}{35\p@}
  \twocolumn[\chapter{\indexname}]
  \setlength{\parindent}{\z@}
  \setlength{\parskip}{\z@ \@plus .3\p@\relax}
  \let\item\@idxitem}
  \onecolumn
\newcommand{\@idxitem}{\par\hangindent 40\p@}
\newcommand{\subitem}{\@idxitem \hspace*{20\p@}}
\newcommand{\subsubitem}{\@idxitem \hspace*{30\p@}}
\newcommand{\indexspace}{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
%  ********************************-**********************************
%  *                           FOOTNOTES                             *
%  ********************************-**********************************
\renewcommand{\footnoterule}{
  \kern-3\p@
  \hrule\@width.4\columnwidth
  \kern2.6\p@}
\@addtoreset{footnote}{chapter}
\newcommand{\@makefntext}[1]{
  \setlength{\parindent}{1em}
  \noindent
  \hb@xt@1.8em{\hss\@makefnmark}#1}
%  ********************************-**********************************
%  *                                                                 *
%  ********************************-**********************************
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}
%
\renewcommand{\author}[1]{\gdef\@author{#1}}
\newcommand{\authorshort}[1]{\gdef\@authorshort{#1}}
\newcommand{\degree}[1]{\gdef\@degree{#1}}
\newcommand{\department}[1]{\gdef\@department{#1}}
\newcommand{\submissiondate}[1]{\gdef\@submissiondate{#1}}
\newcommand{\head}[1]{\gdef\@head{#1}}
\newcommand{\dean}[1]{\gdef\@dean{#1}}
\newcommand{\copyrightyear}[1]{\gdef\@copyrightyear{#1}}
\newcommand{\contentsname}{TABLE OF CONTENTS}
\newcommand{\listfigurename}{LIST OF FIGURES}
\newcommand{\listtablename}{LIST OF TABLES}
\newcommand\bibname{REFERENCES CITED}
\newcommand{\bibliographyname}[1]{\gdef\@bibname{#1}}
%\newcommand\bibliographyname{REFERENCES CITED}
\newcommand{\indexname}{INDEX}
\newcommand{\figurename}{Figure}
\newcommand{\tablename}{Table}
\newcommand{\partname}{PART}
\newcommand{\chaptername}{CHAPTER}
\newcommand{\sectionname}{SECTION}
\newcommand{\subsectionname}{SUBSECTION}
\newcommand{\appendixname}{APPENDIX}
\newcommand{\today}{}
\edef\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
%  ********************************-**********************************
%  *                        INITIALIZATION                           *
%  ********************************-**********************************
\AtBeginDocument{\setlength{\baselineskip}{30\p@}}
\pagestyle{plain}
\pagenumbering{arabic}
\raggedbottom
\onecolumn
\endinput







