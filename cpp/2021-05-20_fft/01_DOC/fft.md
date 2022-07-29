# 고속 푸리에 변환

https://helloworldpark.github.io/mathematics/2017/02/26/FFT_03.html

https://ko.wikipedia.org/wiki/%EA%B3%A0%EC%86%8D_%ED%91%B8%EB%A6%AC%EC%97%90_%EB%B3%80%ED%99%98

일반적인 이산 푸리에 변환은 N개의 데이터를 연산할 때, NxN 번 연산을 실행해야 한다. 데이터의 개수 N이 커질수록 연산량은 기하급수적으로 증가하는 것.

이를 해결하기 위해 등장한 것이 고속 푸리에 변환이다.



## Divide and conquer

고속 푸리에 변화의 핵심은 분할과 정복.

이는 복잡한 연산 과정을 단순한 여러개의 과정으로 쪼개가는 것을 의미



정의에서 ![식1](image/for_1.svg)

를 다시 정의하면

![수식2](image/for_2.svg)

예를 들어 N=4일 때, 이 식을 아래와 같이 행렬로 표현할 수 있다.
$$
N = 4\\
f_0 = x_0W^{0*0=0} + x_1W^{0*1=0} + x_2W^{0*2=0} + x_3W^{0*3=0} \\
f_1 = x_0W^{1*0=0} + x_1W^{1*1=1} + x_3W^{1*2=2} + x_3W^{1*3=3} \\
f_2 = x_0W^{2*0=0} + x_1W^{2*1=2} + x_3W^{2*2=4} + x_3W^{2*3=6} \\
f_3 = x_0W^{3*0=0} + x_1W^{3*1=3} + x_3W^{3*2=6} + x_3W^{3*3=9} \\
$$
![수식3](image/for_3.svg)

지수의 짝홀을 기준으로 위의 식을 다음과 같이 변형할 수 있다.

![수식4](image/for_4.svg)
$$
f_0 = W^0x_0 + W^0x_2 + W^0x_1 + W^0x_3 = W^0x_0 + W^0x_2 + W^0W^0x_1 + W^0W^0x_3
$$

$$
f_1 = W^0x_0 + W^2x_2 + W^1x_1 + W^3x_3 = W^0x_0 + W^2x_2 + W^1W^0x_1 + W^1W^2x_3
$$

$$
f_2 = W^0x_0 + W^4x_2 + W^2x_1 + W^6x_3 = W^0x_0 + W^0x_2 + W^2W^0x_1 + W^2W^0x_3
$$

$$
f_3 = W^0x_0 + W^6x_2 + W^3x_1 + (W^9 = W^1)x_3 = W^0x_0 + W^2x_2 + W^3W^0x_1 + W^3W^2x_3
$$

이는 다음과 같이 다시 쓸수 있으므로 N=4인 DFT는 N=2인 DFT 두 개를 사용해서 계산할 수 있음.
$$
W^0 = W^4\\
W^1 = W^5\\
W^2 = W^6\\
W^3 = W^7
$$
![회전요소](image\fft_spinfact.png)



![수식5](image/for_5.svg)
$$
=
\begin{pmatrix} 
1 & 0 & W^0 & 0 \\
0 & 1 & 0 & W^1 \\
1 & 0 & W^2 & 0 \\
0 & 1 & 0 & W^3
\end{pmatrix}
\begin{pmatrix}
\begin{pmatrix}
W^0x_0 + W^0 x_2\\
W^0x_0 + W^2x_2
\end{pmatrix} \\
\begin{pmatrix}
W^0x_1 + W^0x_3 \\
W^0x_1 + W^2x_3
\end{pmatrix}
\end{pmatrix}
$$

$$
f_0 = W^0x_0 + W^0x_2 + W^0(W^0x_1 + W^0x_3)\\ = W^0x_0 + W^0x_2 + W^0W^0x_1 + W^0W^0x_3\\ = W^0x_0 + W^0x_1 + W^0x_2 + W^0x_3
$$

$$
f_1 = W^0x_0 + W^2x_2 + W^1(W^0x_1 + W^2x_3)\\
= W^0x_0 + W^2x_2 + W^1W^0x_1 + W^1W^2x_3\\
= W^0x_0 + W^1x_1 + W^2x_2+ W^3x_3
$$

이 과정을 재귀적으로 적용하면 위 수식과 같음.

이러한 분할과정을 그림으로 그리면 나비모양의 그림이 나오기 때문에 butterfly operation이라고도 불림

