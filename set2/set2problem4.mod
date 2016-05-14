/******************************************************
	Author: Igor Dyczko 200477
******************************************************/
param n; #Ilość zadań
param dur; #Czas wykonania zadań

#Czasy dostępności poszczególnych zadań:
param ready{1..n};
#Priorytety poszczególnych zadań:
param weight{1..n};

#Duża liczba pozwalająca zachować ograniczenia:
param BigM := (max {k in 1..n} ready[k] ) + n*dur;

#Zmienna decyzyjna - które zadanie należy zakończyć w jakiej jednostce czasu:
var job{1..n, 1..dur} >= 0;
#Pomocnicza zmienna decyzyjna - pozwala wyeliminować nakładanie się czasów wykonania zadań:
var y{(i,j,k,l) in {1..n,1..dur,1..n,1..dur}} binary;

#Funkcja celu - kara:
minimize penalty: sum{i in 1..n}job[i, dur]*weight[i];

#Ograniczenie na czas rozpoczęcia zadania:
s.t. start_time{k in 1..n}: job[k, 1] >= ready[k];
#Ograniczenie na stopniowe wykonywanie etapów zadań:
s.t. job_order_constraint{(k,l) in {1..n, 1..(dur-1)}}: job[k, l] + 1 <= job[k, l+1];

#Ograniczenia pozwalające wyeliminować nakładanie się zadań:
s.t. machine_constraint_1{(j,k,l,m) in {1..n,1..n,1..dur,1..dur}: j < k}:
   job[j,l] +1<= job[k,m] + BigM*(1-y[j,l,k,m]);
s.t. machine_constraint_2{(j,k,l,m) in {1..n,1..n,1..dur,1..dur}: j < k}:
   job[k,m] +1<= job[j,l] + BigM*y[j,l,k,m];

solve;
display job;
param r{(i,j) in {1..n,1..dur}} := 1 + sum {(k,l) in {1..n,1..dur}} if (job[k,l] < job[i,j] || job[k,l] == job[i,j]) then 1;
printf "Kolejność wykonywania zadań:\n";
printf {k in 1..n*dur, (i,j) in {1..n,1..dur}: k == r[i,j]}  "%s ", i;
printf "\n";
