# LaTeX 사용법

[참조사이트](https://www.latex4technics.com/?note=CM5)

1. .tex 파일 :
   - 논문 작성을 위한 실질적인 코드
2. .bst 파일:
   - tex 파일의 레퍼런스를 특정 논문지 형식으로 컴파일 시켜주는 옵션
3. .cls 파일:
   - tex 파일을 특정 논문지 형식으로 컴파일시켜주는 옵션
4. .bib 파일:
   - 참조 논문의 정보를 저장하는 파일
   - 이를 tex 파일에서 참조

## 제목 작성

```latex
\title{ ***논문 제목*** } : 논문의 시작, 논문의 제목을 입력하는 부분

\end{ document } : 논문의 끝
```

## 레퍼런스 작성

```latex
\bibliographystyle{ ***파일명.bst*** } : 
```

- 파일명에서 확장자는 기본적으로 생략

```latex
\bibliography { ***파일명.bib*** } :
```

- 확장자명은 생략
- 해당 파일로부터 참조 논문 정보를 가져오게 됨

### 레퍼런스 참조

```latex
@INPROCEEDINGS{ ***이름*** }
```

- .bib 파일에서 레퍼런스 논문 정보의 약칭
- 이를 .tex 파일에서 해당 이름으로 참조함

## 섹션 구성

```latex
\section{ ***이름*** }
```

- 섹션의 선언은 위와 같이 선언

```latex
\subsection{ ***이름*** }
```

- 서브섹션의 경우 상위에 \section 항목이 있다면,
- subsection을 위와 같이 할당하면 컴파일 시, 생성

## 그림 추가

```latex
\begin{ 그림명* }[t]
\centering % 중앙 위치로 이동 
{
	\includegraphics[width=1.0\textwidth]{./경로/파일명}
	\caption*{}
}
\end{그림명*}
```

- *은 column을 무시

## 한글 사용하기

- 에디터 내에서 **\usepackage{korex}** 설정

## 소스코드 넣기

```latex
\usepackage{listings}
\begin{document}
\begin{lstlisting}[
    basicstyle=\tiny %or \small or \footnotesize etc.
]
int isJava = 1;
\end{lstlisting}
\end{document}
```

## 그림을 같은 행에 두개 넣는데 캡션을 따로

```tex
\begin{minipage}{\linewidth}
\begin{minipage}{0.45\linewidth}
\begin{figure}[H]
	\includegraphics[width=\linewidth]{./Figure/hw_component}
	\caption{Hardware component}
	\label{hw_component}
\end{figure}
\end{minipage}
\hspace{0.01\linewidth}
\begin{minipage}{0.45\linewidth}
\begin{figure}[H]
	\includegraphics[width=\linewidth]{./Figure/sw_config_init}
	\caption{System configuration}
	\label{sw_config_init}
\end{figure}
\end{minipage}

\end{minipage}
```

## 그림을 행을 무시하고 크게

```tex
\begin{figure*}
\centering{	
\includegraphics[width=1\linewidth]{./Figure/system_protocol}
\caption{Protocol configuration} \label{sys_protocol}
}
\end{figure*}
```
