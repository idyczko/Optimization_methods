/*********************************************
 * OPL 12.6.1.0 Model
 * Author: Igor Dyczko
 * Creation Date: 24-05-2016 at 22:12:01
 *********************************************/
//Constraint Programming
using CP;
//Ilo�� typ�w odnawialnych zasob�w: 
int p = ...;
//Ilo�� czynno�ci
int n = ...;
//Zbi�r typ�w odnawialnych zasob�w
range R = 1..p;
//Zbi�r czynno�ci
range Z = 1..n;
//Ograniczenia ilo�ciowe na wykorzystywane w jednym czasie zasoby
int N[R] = ...;
//Czasy wykonania poszczeg�lnych zada�
int t[Z] = ...;
//Zapotrzebowanie zada� na zasoby
int r[Z][R] = ...;
//Ograniczenia dotycz�ce poprzedzania poszczeg�lnych zada�
{int} c[Z]=...;

//Zmienna decyzyjna - interwa�y czasowe poszczeg�lnych zada�
dvar interval task[i in Z] size t[i];
//Wyra�enie oznaczaj�ce czas dostarczenia ostatniego zadania
dexpr int makespan = max (i in Z) endOf(task[i]);

//Funkcja celu - minimalizacja czasu dostarczenia ostatniego zadania
minimize makespan;

//Ograniczenia:
subject to {
//Ograniczenia wymuszaj�ce poprzedzanie zada�
  forall(i in Z, j in c[i])
      endBeforeStart(task[j],task[i]);
//Ograniczenia dotycz�ce zarz�dzania zasobami
  forall(i in R)
		sum (j in Z) pulse(task[j],r[j][i])<=N[i];
}

//Skrypt prezentuj�cy rozwi�zanie w postaci diagramu Gantta
execute Gantt{
   writeln();
   writeln("Gantt chart:");
   for(var i in task){  
   writeln(); 
	for(var j=0; j<task[i].start; j++)
   		write(" ");
   	for(var j=0; j<task[i].size; j++)
   		write(i);
}
};