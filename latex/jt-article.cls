\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jt-article}[02/10/2019 Personal LaTeX Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass{article}

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

\RequirePackage[hidelinks]{hyperref}
\urlstyle{same} % make links use normal font

\RequirePackage[parfill]{parskip} % use line breaks instead of indents for paragraphs
\widowpenalties 1 10000 % prevent breaking paragraph over page

\renewcommand*{\maketitle}{
    \begin{centering}
        \LARGE{\textbf{\@title}}\par
        \vspace{.1cm}
        \large{\@author}\par
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

\RequirePackage{tabularx}
\renewcommand{\arraystretch}{1.5} % add padding to tables
\newcommand{\thline}[0]{\noalign{\hrule height 1pt}} % add command for thick hline

\RequirePackage{color}
% add command for listing todos - also shows warning if still in file
\newcommand{\todo}[1]{\textcolor{red}{[ToDo: #1]}\PackageWarning{TODO}{ToDo: #1}}

\RequirePackage{calc}
\RequirePackage{float}

% change default monospace font, and listings style
\RequirePackage[scaled]{beramono}
\RequirePackage[T1]{fontenc}
\RequirePackage{listings}
\lstset{basicstyle=\small\ttfamily,breaklines=true,aboveskip=0pt,belowskip=0pt}

\RequirePackage{graphicx}
\graphicspath{{./img/}}

\newcommand{\boldm}[1] {\mathversion{bold}#1\mathversion{normal}}

\RequirePackage[backend=biber, style=authoryear]{biblatex}
\addbibresource{bibliography.bib}
\setlength\bibitemsep{.5\baselineskip}