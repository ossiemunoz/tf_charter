\def\filename{charter.cls}
\def\fileversion{v. 0.1.0}
\def\filedate{junio 1, 2020}
\def\contributors{Patricio Bos}

\typeout{\filename}
\typeout{\fileversion}
\typeout{Creado por Patricio Bos para el Laboratorio de Sistemas Embebidos de FIUBA}
\typeout{\filedate}
\typeout{Una clase para armar planificaciones de Trabajos finales en el curso de Gestión de Proyectos.}

\ProvidesClass{charter}
\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{color}}%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}%
\ExecuteOptions{12pt}% execute default options
\ProcessOptions%

\LoadClass[a4paper]{article}

%---------- LOAD PACKAGES ----------
\RequirePackage{amsmath,amsthm,amssymb}
\RequirePackage{color}
\RequirePackage{geometry}
\geometry{top=1in,bottom=1in,left=1in,right=1in,vcentering}
\RequirePackage{float}
\RequirePackage{relsize} 
\RequirePackage{url}
%\usepackage[plainpages=false,breaklinks=true,pdfpagelabels=true,pagebackref]{hyperref}
\RequirePackage[english, spanish]{babel}
\RequirePackage[utf8]{inputenc}
\RequirePackage[]{graphicx}
\RequirePackage{lastpage}
\RequirePackage[table]{xcolor}
\RequirePackage{multirow}
\RequirePackage{tabularx}
\RequirePackage{pgfgantt} 
\RequirePackage{graphicx}
\RequirePackage[section]{placeins} % evita que los floats se pueden ubicar más allá de un \section{•}
\RequirePackage{longtable}
\RequirePackage{etoolbox}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage{microtype}
\RequirePackage{array}
\RequirePackage{titlesec}
\RequirePackage{tikz} % agregado OM
\usetikzlibrary{arrows.meta,positioning,shapes.geometric,shapes.multipart,fit,backgrounds,calc}
\RequirePackage{xparse}
\RequirePackage[labelsep=period]{caption} % agregado OM
\RequirePackage{pdflscape} % agregado OM
\RequirePackage{adjustbox} % para escalar diagramas grandes
\RequirePackage{booktabs}
\RequirePackage{makecell}
\RequirePackage{hyphenat}

\newcolumntype{Y}{>{\raggedright\arraybackslash}X}
\newcolumntype{T}{>{\raggedright\arraybackslash}X}

\newbool{codirector}

%----------------------------------------------------------------------------------------
%	DEFINE CUSTOM PLAN INFORMATION COMMANDS 
%----------------------------------------------------------------------------------------
%TODO Uniformizar el nombre de los comandos a camelCase
\def\authorname{}
\def\ttitle{}
\newcommand*{\director}[1]{\def\supname{#1}}
\newcommand*{\pertenenciaDirector}[1]{\def\pertesupname{#1}}
\newcommand*{\codirector}[1]{\def\cosupname{#1}}
\newcommand*{\pertenenciaCoDirector}[1]{\def\pertecosupname{#1}}
\newcommand*{\cliente}[1]{\def\clientename{#1}}
\newcommand*{\empresaCliente}[1]{\def\empclientename{#1}}
\newcommand*{\titulo}[1]{\def\@title{#1}\def\ttitle{#1}}
\newcommand*{\examiner}[1]{\def\examname{#1}}
\newcommand*{\posgrado}[1]{\def\degreename{#1}}
\newcommand*{\autor}[1]{\def\authorname{#1}}
\newcommand*{\addresses}[1]{\def\addressname{#1}}
\newcommand*{\university}[1]{\def\univname{#1}}
\newcommand*{\department}[1]{\def\deptname{#1}}
\newcommand*{\group}[1]{\def\groupname{#1}}
\newcommand*{\faculty}[1]{\def\facname{#1}}
\newcommand*{\subject}[1]{\def\subjectname{#1}}
\newcommand*{\keywords}[1]{\def\keywordnames{#1}}
\newcommand*{\juradoUno}[1]{\def\jurunoname{#1}}
\newcommand*{\pertenenciaJurUno}[1]{\def\perteunoame{#1}}
\newcommand*{\juradoDos}[1]{\def\jurdosname{#1}}
\newcommand*{\pertenenciaJurDos}[1]{\def\pertedosame{#1}}
\newcommand*{\juradoTres}[1]{\def\jurtresname{#1}}
\newcommand*{\pertenenciaJurTres}[1]{\def\pertetresame{#1}}
\newcommand*{\fechaINICIO}[1]{\def\fechaInicioName{#1}}
\newcommand*{\fechaFINALPlan}[1]{\def\fechaFinalPlanName{#1}}
\newcommand*{\fechaFINALTrabajo}[1]{\def\fechaFinalName{#1}} 

% Definiciones de OM
\newcommand{\eng}[1]{\textit{#1}} % itálicas para términos en inglés
\titlespacing*{\subsection}{0pt}{0.5em}{0.5cm} % subsección

% Estilos compactos para los diagramas PMI
\tikzset{%
  every node/.style={font=\normalsize},%
  fase/.style={rectangle,rounded corners,draw,thick,fill=blue!15,%
    minimum width=3.0cm,minimum height=0.9cm,align=center,font=\normalsize},%
  resaltada/.style={fase,fill=orange!25},%
  io/.style={rectangle,draw,rounded corners,fill=gray!10,%
    align=left,inner sep=3pt,text width=5.2cm,font=\normalsize},%
  outbox/.style={rectangle,draw,rounded corners,fill=orange!15,%
    align=left,inner sep=3pt,text width=5.2cm,font=\normalsize},%
  arr/.style={line width=0.9pt,-{Stealth}},%
  arrd/.style={arr,dashed},%
  note/.style={font=\normalsize}%
}

% ==== Macro PMI vertical: Entradas -> Fase -> Salidas (apilado) ====
% Uso: \pmiFase[<opciones fase>]{<título fase>}{<Entradas>}{<Salidas>}
\newcommand{\pmiFase}[4][]{%
  \begin{adjustbox}{max width=.9\linewidth}%
  \begin{tikzpicture}[node distance=7mm and 7mm]%
    % Entradas arriba
    \node (in)   [io]                 {\textbf{Entradas}\\#3};
    % Fase en el centro
    \node (fase) [fase,#1,below=of in]{#2};
    % Salidas abajo
    \node (out)  [outbox,below=of fase]{\textbf{Salidas}\\#4};
    % Flechas
    \draw[arr] (in)   -- (fase);
    \draw[arr] (fase) -- (out);
  \end{tikzpicture}
  \end{adjustbox}%
}

% ==== Macro PMI horizontal: Entradas -> Fase -> Salidas (en línea) ====
% Uso: \pmiFaseH[<opciones fase>]{<título fase>}{<Entradas>}{<Salidas>}
\newcommand{\pmiFaseH}[4][]{%
  \begin{adjustbox}{max width=\linewidth}%
  \begin{tikzpicture}[%
    node distance=1.2cm and 6mm]%
    % Entradas a la izquierda
    \node (in)   [io]                 {\textbf{Entradas}\\#3};%
    % Fase al centro
    \node (fase) [fase,#1, right=of in] {#2};%
    % Salidas a la derecha
    \node (out)  [outbox, right=of fase] {\textbf{Salidas}\\#4};%
    % Flechas
    \draw[arr] (in)   -- (fase);%
    \draw[arr] (fase) -- (out);%
  \end{tikzpicture}%
  \end{adjustbox}%
}

\def\@title{Plan de proyecto del Trabajo Final} %TODO ver si se puede agregar el campo con el nombre del autor acá

\AtBeginDocument{
  \hypersetup{
    pdftitle = {\@title},
    pdfauthor = {\authorname},
    %pdfkeywords={\keywordnames},
    %pdfsubject={\subjectname}%,
%    colorlinks,
%    linkcolor={red!50!black},
%    citecolor={blue!50!black},
%    urlcolor={blue!80!black}
  }
  	\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
	\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
	\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
	%\newcolumntype{Lp}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
	%\newcolumntype{Cp}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
	%\newcolumntype{Rp}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
}

\usetikzlibrary{arrows.meta, positioning, shapes.multipart, shapes.geometric}

% Adds space between caption and table
\captionsetup[table]{position=top}

% Adds hyperlinks to references and ToC
\RequirePackage[
	bookmarks=true,         % show bookmarks bar?
    unicode=false,          % non-Latin characters in Acrobat’s bookmarks
    pdftoolbar=true,        % show Acrobat’s toolbar?
    pdfmenubar=true,        % show Acrobat’s menu?
    pdffitwindow=false,     % window fit to page when opened
    pdfstartview={FitH},    % fits the width of the page to the window
	colorlinks = true,
    linkcolor=black,%{red!50!black},
    citecolor={blue!50!black},
    urlcolor={blue!80!black}]{hyperref}

%% All page numbers positioned at the bottom of the page
\usepackage{fancyhdr}
\fancyhf{} % clear all header and footers
\pagestyle{fancy}

\lhead{\includegraphics[width=3.5cm]{./Figuras/logoFIUBA.pdf}}
\chead{}
\rhead{\normalsize \textrm{Plan de proyecto del Trabajo Final \\\degreename\\ \authorname}}
\lfoot{ }
\cfoot{\normalsize Página \thepage \hspace{1px} de \pageref{LastPage}}
\rfoot{}
\setlength{\fboxrule}{4pt} \setlength{\fboxsep}{2ex}
\setlength{\headheight}{42pt}

\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}

\setlength{\parindent}{0pt}
\setlength{\parskip}{1em}

%enumerate style
\renewcommand{\labelenumii}{\theenumii}
\renewcommand{\theenumii}{\theenumi.\arabic{enumii}.}

\hypersetup{
  bookmarksnumbered = true, 
  pdftitle={\@title}, 
  pdfauthor={\@author},
  pdfpagelayout=OneColumn,
  bookmarksopen=False,
  pdfborder=0 0 0,        % make all links invisible, so the pdf looks good when printed
  pdffitwindow=true,      % window fit to page when opened
  pdfcreator={\@author},  % creator of the document
  pdfnewwindow=true,      % links in new window
%  colorlinks=true,        % false: boxed links; true: colored links
%  linkcolor=blue,         % color of internal links
%  citecolor=blue,         % color of links to bibliography
%  filecolor=magenta,      % color of file links
%  urlcolor=magenta,       % color of external links
  unicode = true
}

%---------- SET HYPHENATION ---------
\hyphenpenalty=5000	% reduce hyphenation as much as possible
\tolerance=1000     % goes with the previous command

%---------- Widow/orphan protection ----------
\clubpenalty=10000    % Minimize orphans orphans(eliminate 10000)
\widowpenalty=10000   % Minimize widows
\brokenpenalty=10000  % Do not allow hyphen across pages
% Use cool footnotes
\renewcommand{\thefootnote}{\fnsymbol{footnote}}
\raggedbottom

% PORTADA
\def\@maketitle{%
\newpage
\thispagestyle{empty}
\centering
	
	\centering \includegraphics[width=.7\textwidth]{./Figuras/logoFIUBA.pdf}
	
	\vspace{3cm}
	{\Huge \textbf{\ttitle}} \\
	\vspace{4cm}
	
	\flushleft
	{\normalsize Autor:\\}
	{\Large \authorname \\}
	\vspace{1cm}
	
	{\normalsize Director:\\}
	{\Large \supname \hspace{1px} (\pertesupname) \\}

\ifdefempty{\cosupname}
  % codirector doesn't exist
  {
    \vspace{2pc}
  }
  % codirector exists
  {
    \vspace{10px}
    \normalsize Codirector:\\
    \Large \cosupname \hspace{1px} (\pertecosupname) \\
  }
		
	
    \vfill
    \centering
    \textit{Esta planificación fue realizada en el curso de Gestión de proyectos\\ entre el \fechaInicioName \hspace{1px} y el  \fechaFinalPlanName.}
		
	\pagebreak
  }

%to do not put numbers in sections
\titleformat{\section}{}{}{0em}{\large\bfseries}

\usepackage{titletoc}
\titlecontents{section}
              [0em]
              {\addvspace{1pc}\bfseries}
              {}
              {}
              {\mdseries\titlerule*[.75pc]{.}\bfseries\contentspage}
    
%\renewcommand{\thesection}{}% Remove section references...
%\renewcommand{\thesubsection}{\arabic{subsection}}%... from subsections

\newenvironment{consigna}[1]{%
    \leavevmode\color{#1}\ignorespaces%
}{%
}%
