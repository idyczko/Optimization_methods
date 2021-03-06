/******************************************************
	Author: Igor Dyczko 200477
******************************************************/
param n; #Ilość maszyn
param m; #Ilość zadań

#Czasy wykonania poszczególnych zadań na poszczególnych maszynach:
param dur{1..m,1..n};

#Duża liczba, pozwalająca na ustalenie kolejności zadań:
param BigM := 1 + sum {(job,mac) in {1..m,1..n}} dur[job,mac];

#Zmienna decyzyjna - czasy rozpoczęcia zadań na poszczególnych maszynach:
var start{1..m, 1..n} >= 0;
#Zmienna decyzyjna - czas zakończenie ostatniego zadania na ostatniej maszynie
var makespan >= 0;
#Pomocnicza zmienna decyzyjna pozwalająca określić kolejność wykonywania zadań:
var y{(job1,mac,job2) in {1..m,1..n,1..m}: job1 < job2} binary;

#Funkcja celu - minimalizacja czasu wykonania ostatniego zadania na ostatniej maszynie:
minimize makespan_objective_function: makespan;

#Ograniczenie wartości zmiennej optymalizowanej przez czas zakończenia wszystkich zadań:
s.t. makespan_constraint{(job,mac) in {1..m,1..n}}: start[job,mac] + dur[job,mac] <= makespan;

#Ograniczenie pozwalające zachowanie kolejności wykonywania zadań na poszczególnych maszynach:
s.t. machine_order_constraint{(job,mac) in {1..m, 1..n-1}}: start[job,mac] + dur[job,mac] <= start[job,mac+1];

#Ograniczenie kolejności wykonywanych zadań - zajętość maszyn.
s.t. jobs_order_constraint_1{(job1,job2,mac) in {1..m,1..m,1..n}: job1 < job2}: 
start[job1,mac] + dur[job1,mac] <= start[job2,mac] + BigM*(1-y[job1,mac,job2]);
s.t. jobs_order_constraint_2{(job1,job2,mac) in {1..m,1..m,1..n}: job1 < job2}: 
start[job2,mac] + dur[job2,mac] <= start[job1,mac] + BigM*y[job1,mac,job2];

solve;

display makespan;

param finish{(job,mac) in {1..m,1..n}} := start[job,mac] + dur[job,mac];

/* Task Summary Report */
printf "\n                TASK SUMMARY\n";
printf "\n     JOB   MACHINE     Dur   Start  Finish\n";
printf {(job,mac) in {1..m,1..n}} "%8s  %8s   %5.2f   %5.2f   %5.2f\n", 
   job, mac, dur[job,mac], start[job,mac], finish[job,mac];

/* Schedule of activities for each job */
set M{job in 1..m} := setof {(job,mac) in {1..m,1..n}} mac;
param r{job in 1..m, mac in M[job]} := 
   1+sum{nac in M[job]: start[job,nac] < start[job,mac] || start[job,nac]==start[job,mac] && nac < mac} 1;
printf "\n\n           JOB SCHEDULES\n";
for {job in 1..n} {
   printf "\n%s:\n",job;
   printf "         MACHINE   Start   Finish\n";
   printf {k in 1..card(M[job]), mac in M[job]: k==r[job,mac]} 
      " %15s   %5.2f    %5.2f\n",mac, start[job,mac],finish[job,mac];
}

/* Schedule of activities for each machine */
set J{mac in 1..n} := setof {(job,mac) in {1..m,1..n}} job;
param s{mac in 1..n, j in J[mac]} := 
   1+sum{k in J[mac]: start[k,mac] < start[j,mac] || start[k,mac]==start[j,mac] && k < j} 1;
printf "\n\n         MACHINE SCHEDULES\n";
for {mac in 1..n} {
   printf "\n%s:\n",mac;
   printf "             JOB   Start   Finish\n";
   printf {k in 1..card(J[mac]), j in J[mac]: k==s[mac,j]} 
      " %15s   %5.2f    %5.2f\n",j, start[j,mac],finish[j,mac];
}
