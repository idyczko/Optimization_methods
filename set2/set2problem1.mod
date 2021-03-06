/******************************************************
	Author: Igor Dyczko 200477
******************************************************/

param m; #Ilość cech
param n; #Ilość miejsc

param T{1..n}; #Czasy dostępu do miejsc (serwerów)
param q{1..m,1..n}; #Obecność informacji na temat danej cechy populacji w danym miejscu

#Zmienna decyzyjna - w których miejscach należy poszukiwać informacji, aby w najmniejszym czasie zgromadzić kompletne dane.
var x{1..n} binary; 

#Funkcja celu - minimalizacja łącznego czasu odzyskiwania danych:
minimize fetch_time: sum{p in 1..n} x[p]*T[p]; 

#Konieczność odzyskania informacji na temat każdej z cech:
s.t. cover_every_property{pr in 1..m}: sum{pl in 1..n}x[pl]*q[pr,pl]>=1; 

solve;

display x;
display fetch_time;
