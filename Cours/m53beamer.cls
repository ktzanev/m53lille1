\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{m53beamer}[3/9/2015 class pour le cours de M53]

\newif\ifsidebar\sidebarfalse % par defaut 4:3 simplifié, sinon 16:10 avec sidebar
\DeclareOption{withsidebar}{
  \sidebartrue
}
\ifsidebar
  \PassOptionsToClass{aspectratio=1610}{beamer}
\else
  \PassOptionsToClass{aspectratio=43}{beamer}
\fi
\newcommand{\forsimple}[1]{\ifsidebar\relax\else#1\fi}
\newcommand{\fornotsimple}[1]{\ifsidebar#1\fi}


\newif\ifnegatif\negatiffalse % par defaut en couleur
\DeclareOption{negatif}{
  \negatiftrue
}

\newif\ifprint\printfalse % par defaut en couleur
\DeclareOption{print}{
  \printtrue
  \PassOptionsToClass{handout}{beamer}
}

\PassOptionsToClass{bigger}{beamer}

\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{beamer}
}
\ProcessOptions\relax

\LoadClass{beamer}
% =============================================================
% --------------- XeLaTeX spécifique
\RequirePackage{fontspec} % pour le bon encodage des PDFs => police lmodern
  \defaultfontfeatures{Ligatures=TeX} % pour avoir les ligatures standards
% ---------------
\RequirePackage{mathtools,amssymb,bm,amsthm} % pour des possibilités en math étendus (mathtools => amsmath)
\RequirePackage[francais]{babel} % pour franciser LaTeX
\uselanguage{French}
\languagepath{French}
\RequirePackage[e]{esvect} % pour les vecteurs

%==============================================================
\setbeamertemplate{navigation symbols}{}% pas de symboles de navigation
\setbeamercovered{transparent} % pour de la semi-transparence à la place de invisible

\ifsidebar
  % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ standard
  % hideothersubsections = cache les sous-sections, sauf pour la section courante
  \usetheme[hideothersubsections,width=23mm,height=3ex]{Berkeley}
  \beamer@headheight=1.5\baselineskip
  % \usetheme{Antibes}
  % \usetheme{Montpellier}
  % \usetheme[hideothersubsections,width=23mm]{Goettingen}
  % \useinnertheme{rectangles}
  % \useinnertheme{circles}
  %\usefonttheme{serif}
  %\usefonttheme{structuresmallcapsserif}
  %\setbeamertemplate{footline}[frame number] % rajout des numéros des frames
  %\useoutertheme{infolines}
  \setbeamertemplate{sidebar \beamer@sidebarside}
  {
    \insertverticalnavigation{\beamer@sidebarwidth}%
    \vfill
    \usebeamerfont{title in sidebar}\usebeamercolor[fg]{title in sidebar}%
    \hspace{7ex}
    \insertframenumber/\inserttotalframenumber
    \vspace{7ex}
  }%
  \logo{\insertshorttitle[width=\beamer@sidebarwidth,center,respectlinebreaks]\par}
\else
  %\usetheme{CambridgeUS}

  \setbeamertemplate{headline}{\nointerlineskip%
    \begin{beamercolorbox}[wd=\paperwidth,ht=2ex,dp=1ex]{secsubsec}%
      \tiny\quad\rule[-.1ex]{1.4ex}{1.4ex}\ \strut\insertsection\ $\blacktriangleright$\ \insertsubsection\hfill
      \insertframenumber/\inserttotalframenumber\qquad{}
    \end{beamercolorbox}}
  \setbeamertemplate{frametitle}{\nointerlineskip%
    \begin{beamercolorbox}[wd=\paperwidth,ht=1.47ex,dp=0.49ex,left]{frametitle}%
      \normalsize\qquad\strut\insertframetitle%
    \end{beamercolorbox}}
\fi
\ifnegatif
  % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ inversé
  \setbeamercolor{normal text}{fg=white,bg=black}
  \setbeamercolor{structure}{fg=white}
  \setbeamercolor{alerted text}{fg=red!85!black}
  \setbeamercolor{item projected}{use=item,fg=black,bg=item.fg!35}
  \setbeamercolor*{palette primary}{use=structure,fg=structure.fg}
  \setbeamercolor*{palette secondary}{use=structure,fg=structure.fg!95!black}
  \setbeamercolor*{palette tertiary}{use=structure,fg=structure.fg!90!black}
  \setbeamercolor*{palette quaternary}{use=structure,fg=structure.fg!95!black,bg=black!80}
  \setbeamercolor*{framesubtitle}{fg=white}
  \setbeamercolor*{block title}{parent=structure,bg=black!90}
  \setbeamercolor*{block body}{fg=white,bg=black!95}
  \setbeamercolor*{block title alerted}{parent=alerted text,bg=black!15}
  \setbeamercolor*{block title example}{parent=example text,bg=black!15}
  \setbeamercolor{secsubsec}{bg=black!80,fg=white}
  \setbeamercolor{frametitle}{bg=black!90,fg=white}
  \newcommand{\myemph}[1]{\textcolor{green!70!white}{\emph{#1}}}
  \setbeamercolor{alerted text}{fg=red!70!white}
\else
  % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ couleur
  \ifsidebar\else
    \setbeamercolor{secsubsec}{bg=black,fg=white}
    \setbeamercolor*{block title}{parent=structure,bg=black!4}
    \setbeamercolor*{block body}{bg=black!1}
  \fi
  \newcommand{\myemph}[1]{\textcolor{green!70!black}{\emph{#1}}}
  \setbeamercolor{alerted text}{fg=red!70!black}
\fi


\ifprint
  % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ pour impression
  \usepackage{pgfpages}
  \pgfpagesuselayout{4 on 1}[a4paper,border shrink=7mm,landscape]
  \usepackage{everypage}
  \usepackage{tikz}
    \AddEverypageHook{%
      \pgfmathsetmacro{\mpage}{int(mod(\thepage,2))}
      \ifnum \mpage=0\relax
        \begin{tikzpicture}[remember picture,overlay]
          \draw[shift={(current page.west)},line width=3.5mm,gray!14,-latex]
            (-2.1,0)--(-.21,0);
        \end{tikzpicture}%
      \fi
      \pgfmathsetmacro{\mpage}{int(mod(\thepage,4))}
      \ifnum \mpage=3\relax
        \begin{tikzpicture}[remember picture,overlay]
          \draw[shift={(current page.north east)},line width=3.5mm,gray!14,-latex]
            (2.1,1.4) -- (.21,.21);
        \end{tikzpicture}%
      \fi
    }
\fi

% ---------------
% pour changer les spacement avant et après les bloques
\addtobeamertemplate{block begin}{%
  \setlength\abovedisplayskip{3pt plus 2pt minus 2pt}%
  \setlength\belowdisplayskip{1pt}%
}{}

% ---------------
\newtheorem{defprop}[theorem]{Définition-Proposition}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{question}{Question}
\theoremstyle{remark}
\newtheorem*{remarque}{Remarque}

%  -------------- Les abréviations standards
\let\ens\mathcal
\newcommand*{\ev}[1]{\vv{\ens{#1}}}
\let\ssi\Leftrightarrow % ou \newcommand\ssi{\;\Leftrightarrow\;}
\newcommand*\isoto{\xrightarrow{\smash{\raisebox{-.28em}{\ensuremath{\sim\kern1pt}}}}}
\DeclareMathOperator{\lin}{\mathcal{L}}
\DeclareMathOperator{\aff}{Aff}
\DeclareMathOperator{\aut}{Aut}
\DeclareMathOperator{\iso}{Iso}
\DeclareMathOperator{\card}{card}
\let\ker\relax\DeclareMathOperator{\ker}{Ker}
\DeclareMathOperator{\im}{Im}
\DeclareMathOperator{\signe}{signe}
\newcommand*{\id}{\mathrm{Id}}
% Espace affine engendré, à utiliser ainsi : \affspan{\ens{A}}, \affspan[\big]{A,B}
\newcommand*{\affspan}[2][]{#1\langle{#2}#1\kern.07em\rangle}
% Enveloppe convexe, à utiliser ainsi : \convhull{\ens{A}}, \convhull[\big]{A,B}
\newcommand*{\convhull}[2][]{#1[{#2}#1\kern.14em]}
% Produit scalaire à utiliser ainsi : \scalprod uv, \scalprod{\vv u}{\vv v}, \scalprod[\big]{\vv A}{\vv B}
\newcommand*{\scalprod}[3][]{#1\langle{#2}\kern1pt #1|{#3}#1\rangle}
\newcommand*{\norm}[1]{\left\|#1\right\|}
\let\d\relax\DeclareMathOperator{\d}{d}
\newcommand*{\poplus}{\overset{\scriptscriptstyle\perp}{\oplus}}

