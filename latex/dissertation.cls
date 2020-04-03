\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dissertation}[27/03/2020 Dissertation LaTeX Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\LoadClass{report}

\RequirePackage{geometry}
\geometry{a4paper, margin=2cm}

\RequirePackage[ddmmyyyy]{datetime}
\RequirePackage[british]{babel}
\RequirePackage{csquotes}
\RequirePackage[bottom]{footmisc} % force footnotes to bottom

\RequirePackage{wrapfig}
\setlength{\columnsep}{0.1cm} % set gap between figure and text

\RequirePackage[skip=0.25cm,textfont={it},labelfont={bf}]{caption} % remove gap between figure and caption, make font small and bold
\RequirePackage{subcaption}
\captionsetup[sub]{font={footnotesize,bf}}

\RequirePackage{enumitem}
\setlist[itemize]{nosep}
\renewcommand{\labelitemii}{$\circ$} % use hollow bullets for 2nd level itemize
\setlist[description]{labelindent=.5cm} % indent descriptions

\RequirePackage[hidelinks]{hyperref}
\urlstyle{same} % make links use normal font

\RequirePackage[parfill]{parskip} % use line breaks instead of indents for paragraphs
\widowpenalties 1 10000 % prevent breaking paragraph over page

\renewcommand*{\maketitle}{
    \begin{centering}
        \Huge{\textbf{\@project}}\par
        \vspace{1cm}
        \includegraphics[width=4cm]{\@crest}\par
        \vspace{1cm}
        \huge{\textbf{\@author}}\par
        \large\textit{\@course\\\@university}\par
        \vspace{1cm}
        \Large{Supervised by \@supervisor}\par
        \vspace{1.5cm}
        \parbox{12.5cm}{
            \centering\normalsize
            \begin{abstract}
                \@abstract
            \end{abstract}\par
            \vspace{.5cm}
            \textbf{Keywords:} \@keywords
        }\par\vspace{1cm}
        \Large{\@date}\par
    \end{centering}
}

\newcommand*{\maketitlepage}{
    \thispagestyle{empty}\null\mbox{}\vfill
    \maketitle
    \vfill\null\newpage\thispagestyle{plain}\setcounter{page}{1}
}

\RequirePackage[nobottomtitles*]{titlesec}
% set spacing after section headings
\titlespacing{\section}{0pt}{.75cm}{.1cm}
\titlespacing{\subsection}{0pt}{.5cm}{.1cm}
\titlespacing{\subsubsection}{0pt}{.25cm}{.1cm}
\renewcommand{\bottomtitlespace}{0pt}

\titleformat{\chapter}[display]
    {\large\centering}
    {\sffamily\MakeUppercase{\chaptertitlename} \thechapter}
    {-.75cm}
    {
        \rule{.5\textwidth}{.5pt}
        \bfseries\huge\\
    }

\titleformat{name=\chapter,numberless}[display]
    {\large\centering}
    {}
    {0pt}
    {
        \bfseries\huge
    }
    [
        \vspace{-.5cm}\rule{.5\textwidth}{.5pt}
    ]

\RequirePackage{tabularx}
\renewcommand{\arraystretch}{1.5} % add padding to tables
\newcommand{\thline}[0]{\noalign{\hrule height 1pt}} % add command for thick hline

\RequirePackage{color}
% add command for listing todos - also shows warning if still in file
\newcommand{\todo}[1]{\textcolor{red}{[ToDo: #1]}\PackageWarning{TODO}{ToDo: #1}}

\RequirePackage{calc}
\RequirePackage{float}
\RequirePackage[section]{placeins} % prevent figures from being placed outside of section

\RequirePackage{libertine}
\RequirePackage{libertinust1math}

% change default monospace font, and listings style
\RequirePackage{fontspec}
\setmonofont[Scale=MatchLowercase]{Fira Code}
\RequirePackage{listings}
\RequirePackage{cshlistings}
\RequirePackage{jslistings}
\RequirePackage{lstfiracode}
\lstset{
    style=FiraCodeStyle,
    basicstyle=\small\ttfamily,
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

\newcommand*{\project}[1]{\gdef\@project{#1}}
\newcommand*{\@project}{Project Title}
\newcommand*{\supervisor}[1]{\gdef\@supervisor{#1}}
\newcommand*{\@supervisor}{Supervisor Name}

\newcommand*{\crest}[1]{\gdef\@crest{#1}}
\newcommand*{\@crest}{}
\newcommand*{\course}[1]{\gdef\@course{#1}}
\newcommand*{\@course}{Course Title}
\newcommand*{\university}[1]{\gdef\@university{#1}}
\newcommand*{\@university}{University Name}

\newcommand{\abstracttext}[1]{\gdef\@abstract{#1}}
\newcommand{\@abstract}{Abstract}
\newcommand*{\keywords}[1]{\gdef\@keywords{#1}}
\newcommand*{\@keywords}{Keywords}