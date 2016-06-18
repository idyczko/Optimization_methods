/******************************************************
	Author: Igor Dyczko 200477
******************************************************/
param m; #Ilość funkcji
param n; #Ilość podprogramów

set I within 1..m; #Zbiór fukncji, które należy obliczyć
param M; #Maksymalna ilość wykorzystanej pamięci.

param t{1..n,1..m}; #Czasy wykonania podprogramów
param r{1..n,1..m}; #Wymagania pamięciowe podprogramów
#Zmienna decyzyjna - których podprogramów należy użyć, do zbudowania całego programu, 
#minimalizując czas wykonania i przestrzegając ograniczenia na złożoność pamięciową: 
var P{1..n, 1..m} binary;

#Funkcja celu - minimalizacja łącznego czasu wykonania programu:
minimize computing_time: sum{(sub,fun) in {1..n, 1..m}} P[sub,fun]*t[sub,fun]; 

#Ograniczenie na pamięć wykorzystaną przez podprogramy:
s.t. memory_constraint: sum{sub in 1..n}(sum{fun in 1..m} P[sub,fun]*r[sub,fun])<=M;

#Ograniczenie wymuszające wykonanie każdej funkcji ze zbioru I:
s.t. cover_every_function{fun in I}: sum{sub in 1..n}P[sub,fun]=1; 	

solve;

display P;
display computing_time;
display memory_constraint;
