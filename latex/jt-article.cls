\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jt-article}[02/10/2019 Personal LaTeX Class]
\LoadClass{article}

\RequirePackage{geometry}
\geometry{a4paper, margin=2cm}

\RequirePackage[ddmmyyyy]{datetime}
\RequirePackage[bottom]{footmisc} % force footnotes to bottom

\RequirePackage{wrapfig}
\setlength{\columnsep}{0.1cm} % set gap between figure and text

\RequirePackage[skip=0pt, font={footnotesize,bf}]{caption} % remove gap between figure and caption, make font small and bold
\RequirePackage{subcaption}
\captionsetup[sub]{font={scriptsize,bf}}

\RequirePackage{enumitem}
\setlist[itemize]{leftmargin=*,nosep}
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
\titlespacing{\section}{0pt}{\parskip}{-\parskip}
\titlespacing{\subsection}{0pt}{\parskip}{-\parskip}
\titlespacing{\subsubsection}{0pt}{\parskip}{-\parskip}
\renewcommand{\bottomtitlespace}{0pt}

\RequirePackage{tabularx}
\renewcommand{\arraystretch}{1.5} % add padding to tables
\newcommand{\thline}[0]{\noalign{\hrule height 1pt}} % add command for thick hline