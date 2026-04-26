\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{sysupptthesis}[2022/01/18 v1.0.0 SYSU thesis presentation class (adapted)]

\LoadClass[aspectratio=169]{beamer}

\RequirePackage{fontspec}
% Set fonts - use available fonts
\setmainfont{Liberation Serif}  % Times-compatible
\setsansfont{Liberation Serif}

\RequirePackage{amsmath}
\RequirePackage{hyperref}
\RequirePackage{tcolorbox}
\RequirePackage{capt-of}
\RequirePackage{xcolor,multicol,booktabs}
\RequirePackage{graphicx,listings,stackengine}
\RequirePackage{tikz}
\RequirePackage{eso-pic}

% ---- Theme Setup ----
\useoutertheme[footline=authorinstitutetitle,subsection=false]{smoothbars}
\makeatletter
\newcommand{\frameofframes}{/}
\newcommand{\setframeofframes}[1]{\renewcommand{\frameofframes}{#1}}
\setbeamertemplate{footline}{
    \begin{beamercolorbox}[colsep=1.5pt]{upper separation line foot}
    \end{beamercolorbox}
    \begin{beamercolorbox}[ht=2.5ex,dp=1.125ex,
      leftskip=.3cm,rightskip=.3cm plus1fil]{author in head/foot}%
      \leavevmode{\usebeamerfont{author in head/foot}\insertshortauthor}%
      \hfill%
      {\usebeamerfont{institute in head/foot}\usebeamercolor[fg]{institute in head/foot}\insertshortinstitute}%
    \end{beamercolorbox}%
    \begin{beamercolorbox}[ht=2.5ex,dp=1.125ex,
      leftskip=.3cm,rightskip=.3cm plus1fil]{title in head/foot}%
      {\usebeamerfont{title in head/foot}\insertshorttitle}%
      \hfill%
      {\usebeamerfont{frame number}\usebeamercolor[fg]{frame number}\insertframenumber~\frameofframes~\inserttotalframenumber}
    \end{beamercolorbox}%
    \begin{beamercolorbox}[colsep=1.5pt]{lower separation line foot}
    \end{beamercolorbox}
  }
\makeatother

\useinnertheme{circles}

\xdefinecolor{SYSU}{RGB}{0,86,31}
\setbeamercolor{footline}{bg=SYSU}
\setbeamercolor{frametitle}{bg=SYSU,fg=white}
\setbeamercolor{title}{bg=SYSU}
\setbeamerfont{frametitle}{size=\large}
\setbeamertemplate{bibliography item}[text]
\setbeamertemplate{caption}[numbered]

\setbeamercolor{palette primary}{use=structure,fg=white,bg=structure.fg}
\setbeamercolor{palette secondary}{use=structure,fg=white,bg=structure.fg!75!black}
\setbeamercolor{palette tertiary}{use=structure,fg=white,bg=structure.fg!50!black}
\setbeamercolor{palette quaternary}{fg=white,bg=structure.fg!50!black}
\setbeamercolor{titlelike}{parent=palette primary}
\setbeamercolor{block title}{bg=SYSU,fg=white}
\setbeamercolor{fine separation line}{}
\setbeamercolor{item projected}{fg=white}
\setbeamercolor{palette sidebar primary}{use=normal text,fg=normal text.fg}
\setbeamercolor{palette sidebar quaternary}{use=structure,fg=structure.fg}
\setbeamercolor{palette sidebar secondary}{use=structure,fg=structure.fg}
\setbeamercolor{palette sidebar tertiary}{use=normal text,fg=normal text.fg}
\setbeamercolor{section in sidebar}{fg=brown}
\setbeamercolor{section in sidebar shaded}{fg=grey}
\setbeamercolor{separation line}{}
\setbeamercolor{sidebar}{bg=SYSU}
\setbeamercolor{sidebar}{parent=palette primary}
\setbeamercolor{structure}{fg=SYSU}
\setbeamercolor{subsection in sidebar}{fg=brown}
\setbeamercolor{subsection in sidebar shaded}{fg=grey}

\AtBeginSection[]{
	\begin{frame}
		\tableofcontents[sectionstyle=show/shaded,subsectionstyle=show/shaded/hide,subsubsectionstyle=show/shaded/hide]
	\end{frame}
}

% ---- Custom Colors ----
\definecolor{dy0}{HTML}{EA7500}
\definecolor{dl}{HTML}{007500}
\definecolor{inference}{HTML}{343300}
\definecolor{ex}{HTML}{7158e2}

% ---- Custom Environments ----
\newcounter{theorema}[section]
\newcounter{defination}[section]
\newcounter{suppose}[section]
\newcounter{inference}[section]
\newcounter{lemma}[section]

\renewcommand{\thetheorem}{\textbf{Theorem \thesection.\arabic{theorema}}}
\renewcommand{\thedefination}{\textbf{Definition \thesection.\arabic{defination}}}
\renewcommand{\theinference}{\textbf{Method \thesection.\arabic{inference}}}
\renewcommand{\thelemma}{\textbf{Lemma \thesection.\arabic{lemma}}}

\newcommand{\s}{\hspace*{-2.7em}}

\newcommand{\mybox}[2][]{
	\begin{tcolorbox}[on line,
		arc=0pt,outer arc=0pt,colback=#1!10!white,colframe=#1,
		boxsep=0pt,left=3pt,right=3pt,top=4pt,bottom=6pt,
		boxrule=0pt,leftrule=1.5pt]#2
\end{tcolorbox}}

\newcommand\BackgroundPicture{
	\begin{tikzpicture}[remember picture,overlay]
		\node[rotate=0,scale=1.0, opacity=0.06] at (current page.center)
            {\fontsize{60pt}{60pt}\selectfont\bfseries SYSU};
	\end{tikzpicture}
}

\renewcommand{\theorem}[2]{\vspace{1em}\s \refstepcounter{theorema} \hspace*{2em} \mybox[dl]{{\footnotesize \color{dl}\thetheorem\hspace{1em}#1}\\[0.3em] \footnotesize \hspace*{2em}#2}\vspace{0.5em}  \par}

\newcommand{\inference}[2]{\vspace{1em}\s \refstepcounter{inference} \hspace*{2em} \mybox[inference]{{\footnotesize \color{inference}\theinference\hspace{1em}#1}\\[0.3em] \footnotesize  \hspace*{1.5em}#2}\vspace{0.5em}   \par}

\newcommand{\defination}[2]{\vspace{1em}\s \refstepcounter{defination} \hspace*{2em} \mybox[dy0]{{\footnotesize \color{dy0}\thedefination\hspace{1em}#1}\\[0.3em] \footnotesize \hspace*{2em}#2}\vspace{0.5em} \par}

\renewcommand{\lemma}[2]{\vspace{1em}\s \refstepcounter{lemma} \hspace*{2em} \mybox[inference]{{\footnotesize \color{inference}\thelemma\hspace{1em}#1}\\[0.3em] \footnotesize \hspace*{2em}#2}\vspace{0.5em}   \par}

\newcommand{\suppose}[2]{\vspace{1em}\s \refstepcounter{suppose} \hspace*{2em} \mybox[ex]{{\footnotesize \color{ex}Hypothesis \thesection.\arabic{suppose}\hspace{1em}#1}\\[0.3em] \footnotesize \hspace*{2em}#2}\vspace{0.5em} \par}
