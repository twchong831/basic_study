# GNUPLOT

- gnuplot은 다양한 종류의 그래프를 그릴 수 있도록 도와주는 툴
- 텍스트 파일로 저장된 로그와 같은 데이터를 그래프로 시각화하는데 사용하고자 함.

## 자료 배치

```tex
0	0.00	0.00	0.00	0.00	0.00	0.00	0.00
1	0.52	0.05	0.05	0.05	0.05	0.05	0.05
2	0.72	0.12	0.12	0.12	0.12	0.12	0.12
3	0.90	0.27	0.27	0.27	0.27	0.27	0.27
4	1.15	0.45	0.45	0.45	0.45	0.45	0.45
5	1.25	0.77	0.82	0.88	0.93	0.98	1.03
6	1.49	0.97	1.04	1.11	1.18	1.26	1.33
7	1.95	1.18	1.27	1.36	1.45	1.54	1.63
8	2.14	1.41	1.53	1.64	1.76	1.87	1.99
9	2.07	1.61	1.73	1.85	1.98	2.10	2.23
10	2.10	1.83	1.98	2.13	2.27	2.42	2.57
11	2.08	2.04	2.23	2.43	2.62	2.82	3.01
12	1.99	2.09	2.31	2.52	2.74	2.95	3.16
13	2.18	2.08	2.29	2.49	2.70	2.91	3.11
14	2.40	2.11	2.32	2.53	2.74	2.95	3.16
15	2.27	2.13	2.34	2.55	2.75	2.96	3.17
16	2.11	2.15	2.35	2.55	2.75	2.95	3.14
17	2.10	2.23	2.44	2.66	2.88	3.10	3.32
18	2.01	2.24	2.48	2.72	2.96	3.20	3.44
19	2.06	2.16	2.38	2.61	2.84	3.06	3.29
20	2.40	2.11	2.32	2.53	2.74	2.96	3.17
...
```

- 기본적인 자료 배치는 위와 같음
- 첫 행은 데이터의 순서를 이후 행은 실제 데이터들을 나타냄

## 실행 방법

```powershell
gnuplot bar.bat
```

- gnuplot의 기본적인 실행은 터미널이나 cmd를 이용한 커맨드 실행
- bar.bat 파일과 같은 배치 파일 형태로 그래프 형태를 설정하고 이를 수행

## 그래프 그리기

### Line Graph

```makefile
plot	"out.txt" using 1:2 title "signal" with lines

pause mouse any "Any key or button will terminate window"
```

- plot : 2차원 그래프를 그리라는 명령어
- out.txt : 해당 파일을 로드
- 1:2 : 로드한 파일의 1번 행을 x축으로 2번 행을 y축 값으로 지정
- signal : 그래프의 타이틀 설정
- lines : 그래프를 선 형태로 그림

![선 그래프](image\basic\basic_graph_line.png)

#### 선 굵기

```makefile
plot	"out.txt" using 1:2 title "signal 1" w l lw 1, \
		"" using 1:3 title "signal 2" w l linewidth 2, \
		"" using 1:4 title "signal 3" w l lw 3, \
		"" using 1:5 title "signal 4" w l lw 4
```

- w : with
- l : line
- lw : line width, 선 굵기 지정
- gnuplot은 위 코드와 같이 축약어를 사용할 수도 있음
- 그래프 별로 선 굵기를 다르게 하여 출력

![선 굵기 그래프](image\basic\basic_line_width.png)

### Points Graph

```powershell
plot	"out.txt" using 1:2 title "signal" with points
```

![도트 그래프](image\basic\basic_graph_points.png)

#### 포인트 크기

```makefile
plot	"out.txt" using 1:2 title "signal 1" w p ps 1, \
		"" using 1:3 title "signal 2" w p ps 2, \
		"" using 1:4 title "signal 3" w points pointsize 3, \
		"" using 1:5 title "signal 4" w points ps 4
```

- p : points
- ps : point size, 포인트 사이즈 설정

![포인트 사이즈 그래프](image\basic\basic_points_size.png)

### Box Graph

```powershell
plot	"out.txt" using 1:2 title "signal" with boxes
```

![박스 그래프](image\basic\basic_graph_box.png)

#### 박스 폭

```makefile
set boxwidth	0.5
plot	"out.txt" using 1:2 title "signal 1" with boxes
```

- set boxwidth : 전체 박스의 폭을 0.5로 지정
- 위와 같이 상단에 set을 해놓으면 해당 설정이 전체 그래프에 동일하게 적용됨

![박스 폭 그래프](image\basic\basic_graph_box_width.png)

### 다수의 그래프 그리기

```makefile
plot	"out.txt" using 1:2 title "signal 1" with lines, \
		"" using 1:3 title "signal 2" with lines, \
		"" using 1:4 title "signal 3" with lines, \
		"" using 1:5 title "signal 4" with lines, \
		"" using 1:6 title "signal 5" with lines, \
		"" using 1:7 title "signal 6" with lines, \
		"" using 1:8 title "signal 7" with lines
pause mouse any "Any key or button will terminate window"
```

- **,\ **: 그래프를 연속적으로 그릴 경우
- 다수의 그래프를 그리기 위해서 위와 같이 구현할 필요가 있음
- 첫 plot 행에서만 로드할 파일명을 입력하고, 이 후 행은 파일 명 입력은 생략하여도 됨
- 아래 그래프와 같이 gnuplot에서 자동적으로 그래프 별로 색을 부여하여 식별이 용이하게 만들어줌
- 이는 point나 bar도 동일

![다수 그래프](image\basic\basic_mulit_graph_line.png)



#### 박스 그래프

```makefile
set boxwidth	0.7
set style data histograms
plot "out_bar.txt"	using 2:xtic(1) title "signal 1",\
				""	using 3 title "signal 2"
```

- data histogram 스타일로 세팅하게 되면 한 지점에 여러개의 막대 그래프를 그릴 수 있음

![막대 그래프 여러개](image\basic\basic_graph_box_mulit.png)

### 그래프 스타일 지정

#### Line type

```makefile
plot	"out.txt" using 1:2 title "signal 1" lt rgb "red" with lines, \
		"" using 1:3 title "signal 2" lt rgb "#58FA58" with lines, \
		"" using 1:4 title "signal 3" lt 1 with lines, \
		"" using 1:5 title "signal 4" lt 2 with lines
```

- lt : Line type, 그래프의 타입(색)을 설정
- rgb : 해당 명령어를 통해 그래프의 색을 지정할 수 있음
  - 색 이름, 색 코드를 통해 색상 지정이 가능함
- lt 1/2 : gnuplot에 지정된 스타일을 사용

![그래프 스타일 지정](image\basic\basic_mulit_graph_linetype.png)

```makefile
plot	"out.txt" using 1:2 title "signal 1" lt rgb "red" with points, \
		"" using 1:3 title "signal 2" lt rgb "#58FA58" with points, \
		"" using 1:4 title "signal 3" lt 1 with points, \
		"" using 1:5 title "signal 4" lt 2 with points 
```

![라인타입 포인트 그래프](image\basic\basic_mulit_graph_linetype_point.png)

- 위 그래프는 lt를 포인트 그래프에 적용한 결과
- signal1과 signal3이, signal 2와 signal4가 같은 모양의 도트를 가지는데 색이 다른 것을 확인할 수 있음
- signal 1과 signal 2는 lt는 지정해주지 않아서 자동적으로 ghuplot에서 할당되었고, 색은 지정한 값에 따라 할당된 것.
- signal 3과 signal 4는 lt를 1과 2로 지정해주었기 때문에 ghuplot에서 가지고 있는 설정 값에 따라 그려진 결과

#### Line style

```makefile
plot	"out.txt" using 1:2 title "signal 1" ls 1 with points, \
		"" using 1:3 title "signal 2" ls 2 with points, \
		"" using 1:4 title "signal 3" ls 3 with points, \
		"" using 1:5 title "signal 4" ls 4 with points 
```

- ls : Line style, 스타일을 설정
- 일반적으로 포인트의 모양을 변화

![line style 그래프](image\basic\basic_mulit_graph_linestyle.png)

#### Box style

```makefile
set boxwidth	0.5
set style fill solid 0.5 
plot	"out.txt" using 1:2 title "signal 1" with boxes
```

- fill solid : 그래프를 채움, 1.0/0.5로 세팅

![1.0 채움 그래프](image\basic\basic_graph_box_style.png)

![0.5 채움 그래프](image\basic\basic_graph_box_style_2.png)

```makefile
set boxwidth	0.1
plot	"out_bar.txt" using 1:2 title "signal 1" with boxes fill pattern 1
```

- 그래프 별로 패턴 지정
- fill pattern 숫자 : 숫자 값에 따라 해당 설정값으로 그래프를 출력

![그래프 패턴](image\basic\basic_graph_box_each_style_01.png)

### 선과 포인트 그래프 같이 그리기

```makefile
plot	"out.txt" using 1:2 title "signal 1" with lp lw 1 lt 1, \
		"" using 1:3 title "signal 2" with lp lw 2 lt 2, \
		"" using 1:4 title "signal 3" with lp lw 3 lt 3, \
		"" using 1:5 title "signal 4" with lp lw 4 lt 4  
```

- lp : linespoints, 선과 점을 같이 표시
- lw : line width, 선의 굵기

![선과 점 그래프](image\basic\basic_mulit_graph_pointNline.png)

## 축 범위 설정

```makefile
set yrange[0:50]
set xrange[0:100]
```

- 그래프 축의 범위를 설정

## 축 이름 지정

```makefile
set xlabel "x"
set ylabel "y"
```

- 축 이름을 그래프 상에서 출력

## 그래프 이름 출력

```makefile
set title	"one Client activated"
```

- 그래프 이름을 그래프 상에서 출력

## 이미지 파일로 저장

```makefile
set term 'png'
set output 'image.png'
plot "log.txt" using 1:2 title "signal" pt 5 ps 1
unset output
```

- term : 저장할 파일의 종류 설정
- output : 실행이 종료되면 결과를 해당 파일로 저장

## 이미지 파일의 크기 설정

```makefile
set term png size 2000,2000
```

- term 명령어 사용 시, size 명령어를 추가적으로 사용하면
- 저장하는 이미지의 크기를 설정할 수 있음

## 루프를 통해 연속된 그래프 그리기

```makefile
do for [i=0:15]{
	outfile = sprintf('plot_00_ch%d.png', i)
	set output outfile

	plotname = sprintf('CH[%d]', i)
		
	val = i+2

	plot "log.txt" using 1:val title plotname pt 5 ps 1
}
```

- do for [i=0:15] : for문 루프, i라는 변수를 통해 0부터 15까지 증가함
- 파일 이름, 그래프 이름 등을 for문 루프에 따라 변경하고자 한다면
  - 기존 c와 같이 sprintf문으로 %d를 통해 입력 가능
- 그래프를 그릴 행 선택
  - val = i+2 : 헹의 위치를 해당 코드와 같이 지정
  - 1:val 에서 해당 행을 파싱하여 그래프를 그림

## PCD 파일

PCL에서 로그 파일 형식으로 사용하는 pcd 파일을 기반으로 gnuplot을 이용하여 그래프를 그리는 방법

### 2차원

#### 그래프 그리기

```xml
# .PCD v0.7 - Point Cloud Data file format
VERSION 0.7
FIELDS x y z rgb
SIZE 4 4 4 4
TYPE F F F U
COUNT 1 1 1 1
WIDTH 18560
HEIGHT 1
VIEWPOINT 0 0 0 1 0 0 0
POINTS 18560
DATA ascii
0 0.22 0 4294901760
0 0.22 0 4294901760
0 0.22 0 4294901760
0 0.22 0 4294901760
0 0.22 0 4294901760
0 0.22 0 4294901760
0 0.22 0 4294901760
0 0.22 0 4294901760
0 0.22 0 4294901760
0 0.22 0 4294901760
0 0.22 0 4294901760
0 0.22 0 4294901760
```

- pcd 파일의 형식은 위와 같음
- 위 pcd 파일은 ASCII 기반으로 파일을 작성
- 데이터 순서대로 x, y, z와 컬러코드 10진수를 의미

```makefile
do for [i=363:439]{
	outputfile = sprintf("log_front_%d.png", i)
	set output outputfile
	file= sprintf("log/PCDLOG_LiDAR(%d).pcd", i)

	set xlabel	"x"
	set ylabel	"z"

	plot	file using 1:3 with point ps 3 pt 7

	unset output
}
```

- 연속된 로그 파일을 읽어 그래프 그림을 그리기 위해 위와 같이 작성
- 2차원 그래프를 그리므로,  x축을 기준으로 y축 값을 포인트의 z 값을 할당하게 되면 프론트 뷰의 2차원 그래프를 그리게 됨
- 탑뷰의 그래프를 그리고자 한다면, y 축 값을 포인트의 y 축 값을 할당

#### 포인트별 색

- pcd 파일 작성 시, 각 포인트 별로 컬러 값을 가지고 있음
- 이를 gnuplot 상에 표현하고자 함.

```makefile
do for [i=363:439]{
	outputfile = sprintf("log_front_%d.png", i)
	set output outputfile
	file= sprintf("log/PCDLOG_LiDAR(%d).pcd", i)

	set xlabel	"x"
	set ylabel	"z"

	plot	file using 1:3:4 with point palette z ps 3 pt 7

	unset output
}
```

- 위 코드와 같이 file을 읽을 때, z값으로 포인트의 색상코드를 읽어옴
- 이를 기반으로 palette 명령어를 통해 z 값을 색상을 변경하도록 설정

#### 필터링

```makefile
	plot	file using 1:($2<13 ? $3:NaN):($2<13 ? $2:1/0) with point palette z ps 2 pt 7
```

- 조건을 통해 특정 값을 필터링하여 출력
- ($2<13 ? $3:NaN)
  - 파일로부터 2번째 열을 읽어 들임($2)
  - 2번째 열의 값을 비교 (<13)
  - 조건을 만족한다면 $3 값을 할당하고
  - 조건을 불만족할 경우 NaN 값을 할당
  - NAN 값은 그래프 상에서 출력되지 않음

![조건에 따른 출력 변화](image\pcd\condition_point.png)

####  로그의 색 값으로 출력

```makefile
rgb(r,g,b) = int(r)*65536 + int(g)*256 + int(b)
plot	file using 1:2:(rgb($3, $4, $5)) with point ps 2 pt 7 lc rgb variable 

```

- 로그 파일에 기록된 RGB 값을 기반으로 그래프를 그릴 경우
- rgb 함수를 위 코드와 같이 정의
- lc rgb variable 명령어를 통해 z 값에 할당한 색상 값을 그래프에 적용할 수 있음

## 폴더 내 검색

```makefile
do for [file in systme("ls")] {
	print file
}

do for [file in system("cd 'Dir'; ls")]{
	dirFile = "./Dir/".file
	print dirFile
}

```

- for문을 통해 특정 폴더 내의 파일을 검색하고 그 결과를 출력
- 특정 폴더로 이동하여 검색하고자 한다면, cd 명령어를 이용하고
- 해당 경로를 삽입하고자 한다면, dirFile과 같이 .을 통해 문자열을 합칠 수 있음

## 파일명으로부터 숫자 추출

```makefile
#0123456789(10)(11)(12)(13)
#fileName_1.txt

get2Num(f) = substr(f, 8, strlen(f)-4) + 0
```

- 입력받은 문자열로부터 특정 위치의 숫자를 추출하는 함수
- 0을 더해주어야 받는 변수 쪽에서 이를 int 형으로 인식
- 0을 더해주지 않을 경우 string으로 인식

## 파일 존재 여부 확인

```makefile
fileExist(f) = system("echo '".f."';  [ ! -f '".f."' ]; echo $?")
```

- gnuplot에서 exists()함수를 지원하는데 제대로 검출이 안되는 듯...?
- 위 함수를 통해 폴더 내의 파일 존재 여부를 확인할 수 있으며
- 있으면 1을, 없으면 0을 리턴

## HSV를 RGB로

```makefile
plot file using 1:2:hsv2rgb(h/360, s, v) with p lc rgb variable
```

- gnuplot에서 지원하는 hsv2rgb 함수를 이용
- h,s,v는 1.0까지 세팅
- plot 상에서 표현하기 위해 lc rgb variable을 사용하여 각 지점의 색을 표현

## 값 계산하기

```makefile
stats file using 1:2
print STATS_max_x
print STATS_min_x
print STATS_max_y
print STATS_min_y

stats file using 2
print STATS_max
print STATS_min
```

- stats를 통해 입력한 값들을 기반으로 자동 연산
- 여러 축의 값을 입력할 경우 해당 축을 값이 변수명에
- 한 축만을 가지고 있다면, 축이름 없이 찾고자 하는 값의 이름만을 불러서 
- 해당 값을 확인할 수 있음

### STATS 리스트

| `STATS_records`    |      | total number of in-range data records           |
| ------------------ | ---- | ----------------------------------------------- |
| `STATS_outofrange` |      | number of records filtered out by range limits  |
| `STATS_invalid`    |      | number of invalid/incomplete/missing records    |
| `STATS_blank`      |      | number of blank lines in the file               |
| `STATS_blocks`     |      | number of indexable datablocks in the file      |
| `STATS_columns`    |      | number of data columns in the first row of data |

| `STATS_min`          |      |      | minimum value of in-range data points              |
| -------------------- | ---- | ---- | -------------------------------------------------- |
| `STATS_max`          |      |      | maximum value of in-range data points              |
| `STATS_index_min`    |      |      | index i for which data[i] == STATS_min             |
| `STATS_index_max`    |      |      | index i for which data[i] == STATS_max             |
| `STATS_mean`         |      |      | mean value of the in-range data points             |
| `STATS_stddev`       |      |      | population standard deviation of the in-range data |
| `STATS_ssd`          |      |      | sample standard deviation of the in-range data     |
| `STATS_lo_quartile`  |      |      | value of the lower (1st) quartile boundary         |
| `STATS_median`       |      |      | median value                                       |
| `STATS_up_quartile`  |      |      | value of the upper (3rd) quartile boundary         |
| `STATS_sum`          |      |      | sum                                                |
| `STATS_sumsq`        |      |      | sum of squares                                     |
| `STATS_skewness`     |      |      | skewness of the in-range data points               |
| `STATS_kurtosis`     |      |      | kurtosis of the in-range data points               |
| `STATS_adev`         |      |      | mean absolute deviation of the in-range data       |
| `STATS_mean_err`     |      |      | standard error of the mean value                   |
| `STATS_stddev_err`   |      |      | standard error of the standard deviation           |
| `STATS_skewness_err` |      |      | standard error of the skewness                     |
| `STATS_kurtosis_err` |      |      | standard error of the kurtosis                     |

| `STATS_correlation`   |      | sample correlation coefficient between x and y values |
| --------------------- | ---- | ----------------------------------------------------- |
| `STATS_slope`         |      | A corresponding to a linear fit y = Ax + B            |
| `STATS_slope_err`     |      | uncertainty of A                                      |
| `STATS_intercept`     |      | B corresponding to a linear fit y = Ax + B            |
| `STATS_intercept_err` |      | uncertainty of B                                      |
| `STATS_sumxy`         |      | sum of x*y                                            |
| `STATS_pos_min_y`     |      | x coordinate of a point with minimum y value          |
| `STATS_pos_max_y`     |      | x coordinate of a point with maximum y value          |

## label

```makefile
# xlabel : x 축 이름
# ylabel : y 축 이름
# xtics : x 축 눈금
# ytics : y 축 눈금
# title : 제목
```

### 기본

```makefile
#			라벨명	  폰트        offset [가로],[세로],[] - 값이 음수일 때 멀어짐
set xlabel "x-tics" font ",20" offset 0,-1,0
set ylabel "y-tics" font ",10" offset 4,0,0
```

![xlabel/ylabel](image\label\test_label.png)

### 특정 위치 출력

```makefile
set label "test label" at 2,2
```

![라벨위치](image\label\test_label2.png)

### margin

```makefile
set tmargin 1	#top
set lmargin 2	#left
set bmargin 3	#bottom
set rmargin 4	#right
```

![마진변경](image\label\test_label3.png)

- 마진이 변경됨에 따라 x,y 축의 타이틀이 사라진 것을 확인할 수 있음

```makefile
set tmargin 1
set lmargin 2
set bmargin 3
set rmargin 4

set xlabel	"x-tics" font ",20" offset 0,0,0
set ylabel	"y-tics" font ",40" offset 6,0,0
```

![마진 최적화](image\label\test_label4.png)

- 마진 값에 따라 출력되는 범위가 달라지므로,
- x/y label의 offset 값을 적절히 조절해줄 필요가 있음

### 특정 값 입력하여 label로 출력

```makefile
i=3.5
str = gptinf("test label : %g", i)
set label str at 2,2
```

![라벨 숫자입력](image\label\test_label5.png)
