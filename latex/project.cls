\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{project}[02/10/2019 LaTeX Class for Project Documents]
\LoadClass{jt-article}

\newcommand*{\project}[1]{\gdef\@project{#1}}
\newcommand*{\@project}{Project Title}
\newcommand*{\supervisor}[1]{\gdef\@supervisor{#1}}
\newcommand*{\@supervisor}{Supervisor Name}

\renewcommand*{\maketitle}{
\begin{centering}
    \huge{\textbf{\@project}}\par
    \LARGE{\@title}\par
    \vspace{.25cm}
    \Large{\textbf{\@author}}\par
    \large{Supervised by \@supervisor}\par
\end{centering}
}