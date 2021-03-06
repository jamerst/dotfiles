\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dissertation}[27/03/2020 Dissertation LaTeX Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\LoadClass{report}

\RequirePackage{geometry}
\geometry{a4paper, margin=2.5cm}

\RequirePackage{setspace}
\onehalfspacing

\RequirePackage[UKenglish]{babel}
\RequirePackage[UKenglish, nodayofweek]{datetime}
\RequirePackage{csquotes}
\RequirePackage[bottom]{footmisc} % force footnotes to bottom

\RequirePackage{wrapfig}
\setlength{\columnsep}{0.1cm} % set gap between figure and text

\RequirePackage[skip=0.25cm,textfont={it},labelfont={bf}]{caption} % remove gap between figure and caption, make font small and bold
\RequirePackage{subcaption}
\captionsetup[sub]{font={footnotesize,bf}}

\RequirePackage{enumitem}
\setlist{before=\singlespacing}
\renewcommand{\labelitemii}{$\circ$} % use hollow bullets for 2nd level itemize
\setlist[description]{labelindent=.5cm} % indent descriptions

\RequirePackage[hyphens]{xurl}
\RequirePackage[hidelinks,pdfusetitle]{hyperref}
% \urlstyle{same} % make links use normal font

\RequirePackage[parfill]{parskip} % use line breaks instead of indents for paragraphs
\setlength{\parskip}{0.75\baselineskip plus 2pt}
% \widowpenalties 1 10000 % prevent breaking paragraph over page

\renewcommand*{\maketitle}{
    \begin{centering}
        \singlespacing
        \Huge{\textbf{\@title}}\par
        \vspace{1cm}
        \includegraphics[width=4cm]{\@crest}\par
        \vspace{1cm}
        \LARGE{\textbf{\@author}}\par
        \large\textit{\@course\\\@university}\par
        \vspace{1cm}
        \Large{Supervised by \@supervisor}\par
        \vspace{1.5cm}
        \parbox{12.5cm}{
            \centering\normalsize
            \textbf{Keywords:} \@keywords
        }\par\vspace{1cm}
        \Large{\today}\par
    \end{centering}
}

\newcommand*{\maketitlepage}{
    \thispagestyle{empty}\vspace*{\fill}
    \maketitle
    \vspace*{\fill}\newpage\thispagestyle{plain}\setcounter{page}{1}
}

\RequirePackage[nobottomtitles*]{titlesec}
% set spacing after section headings
\titlespacing{\chapter}{0pt}{0pt}{1.5cm}
\titlespacing{\section}{0pt}{.75cm}{.1cm}
\titlespacing{\subsection}{0pt}{.5cm}{.1cm}
\titlespacing{\subsubsection}{0pt}{.25cm}{.1cm}
\renewcommand{\bottomtitlespace}{0pt}

\titleformat{\chapter}[display]
    {\large\centering}
    {\sffamily\MakeUppercase{\chaptertitlename} \thechapter}
    {-1.25cm}
    {
        \rule{.5\textwidth}{.5pt}
        \bfseries\huge\\\vspace{-.3cm}
    }

\titleformat{name=\chapter,numberless}[display]
    {\large\centering}
    {}
    {0pt}
    {
        \bfseries\huge
    }
    [
        \vspace{-1.25cm}\rule{.5\textwidth}{.5pt}
    ]

\RequirePackage{tabularx}
% \renewcommand{\arraystretch}{1.5} % add padding to tables
\newcommand{\thline}[0]{\noalign{\hrule height 1pt}} % add command for thick hline

\RequirePackage{color}
% add command for listing todos - also shows warning if still in file
\newcommand{\todo}[1]{\textcolor{red}{[ToDo: #1]}\PackageWarning{TODO}{ToDo: #1}\\}

\RequirePackage{calc}
\RequirePackage{float}
\RequirePackage[section]{placeins} % prevent figures from being placed outside of section

\RequirePackage{amsmath}
\RequirePackage{amssymb}

% change default and math fonts
\RequirePackage{fontspec}
\RequirePackage{libertine}
\RequirePackage{unicode-math}
\setmathfont[Scale=MatchUppercase]{Libertinus Math}

% change default monospace font, and listings style
\setmonofont[Scale=MatchLowercase]{Fira Code}
\RequirePackage{listings}
\RequirePackage{cshlistings}
\RequirePackage{jslistings}
\RequirePackage{lstfiracode}
\lstset{
    style=FiraCodeStyle,
    basicstyle=\footnotesize\ttfamily\linespread{1},
    breaklines=true,
    aboveskip=\baselineskip,
    belowskip=0pt,
    frame=single
}

\RequirePackage{graphicx}
\graphicspath{{./img/}}

\newcommand{\boldm}[1] {\mathversion{bold}#1\mathversion{normal}}

\RequirePackage[backend=biber]{biblatex}
\addbibresource{bibliography.bib}
\setlength\bibitemsep{.5\baselineskip} % add spacing between items
% fix long urls not breaking line
\setcounter{biburllcpenalty}{7000}
\setcounter{biburlucpenalty}{8000}

\RequirePackage{pdflscape}

\RequirePackage[toc]{appendix}
% make appendices appear under a single heading as if they were sections
\AtBeginDocument{\let\report@l@chapter\l@chapter}
\AtBeginDocument{\let\report@l@section\l@section}
\let\origapp=\appendices
\let\origendapp=\endappendices
\def\appendices{% run original start command, then change TOC level
    \origapp%
    \addtocontents{toc}{\let\protect\l@chapter\protect\l@section\let\protect\l@section\protect\l@subsection}%
}
\def\endappendices{% reset, then finish appendix
    \addtocontents{toc}{\let\protect\l@chapter\protect\report@l@chapter\let\protect\l@section\protect\report@l@section}%
    \origendapp%
}

\RequirePackage[nottoc]{tocbibind} % show bibliography in TOC

\newcommand*{\supervisor}[1]{\gdef\@supervisor{#1}}
\newcommand*{\@supervisor}{Supervisor Name}
\newcommand*{\crest}[1]{\gdef\@crest{#1}}
\newcommand*{\@crest}{}
\newcommand*{\course}[1]{\gdef\@course{#1}}
\newcommand*{\@course}{Course Title}
\newcommand*{\university}[1]{\gdef\@university{#1}}
\newcommand*{\@university}{University Name}
\newcommand*{\keywords}[1]{\gdef\@keywords{#1}}
\newcommand*{\@keywords}{Keywords}