/******************************************************
	Author: Igor Dyczko 200477
******************************************************/

param number_of_months_to_plan_ahead>=0; #Na ile miesiecy nalezy zaplanowac zatrudnienie.
param stewardess_quiting_fraction>=0; #Ulamek doswiadczonych stewardess odchodzacych z pracy.
param maximal_amount_of_working_hours>=0; #Ograniczenie godzin przepracowanych przez jedna stewardesse.
param hours_to_practice>=0; #Ilosc godzin, ktore musi wylatac nowo zatrudniona stewardessa w charakterze praktykantki.
param stewardess_init_number>=0; #Ilosc zatrudnionych na starcie doswiadczonych stewardess.

set stewardess_status; #Status stewardessy.
set months_to_plan_hiring:= 1..number_of_months_to_plan_ahead;#Zbior miesiecy na ktore nalezy zaplanowac zatrudnienie.
set months_with_unknown_experienced_stewardess_number:= 2..number_of_months_to_plan_ahead; /*Zbior miesiecy w ktorych nie znamy ilosci doswiadczonych
												stewardess.*/
param stewardess_wage{stewardess_status}>=0; #Stawka stewardess zalezna od statusu.
param demand{months_to_plan_hiring}>=0; #Zapotrzebowanie na wylatane przez stewardessy godziny.

var stewardess{stewardess_status, months_to_plan_hiring} integer >=0; /*Zmienna decyzyjna - ilosc stewardess doswiadczonych i zatrudnionych
								w kazdym miesiacu.*/

minimize hiring_cost: sum{j in months_to_plan_hiring}(sum{i in stewardess_status}(stewardess[i,j]*stewardess_wage[i])); #Koszty zatrudnienia.
s.t. init_number_of_experienced_stewardess: stewardess['experienced',1]=stewardess_init_number; #Poczatkowa ilosc stewardess.
s.t. staff_constraint{j in months_with_unknown_experienced_stewardess_number}: stewardess['experienced',j]<=stewardess['experienced',j-1]*(1-stewardess_quiting_fraction)+stewardess['hired',j-1]; #Ilosc doswiadczonych stewardess w kolejnych miesiacach.
s.t. demand_constraint{j in months_to_plan_hiring}: stewardess['experienced',j]*maximal_amount_of_working_hours - stewardess['hired',j]*hours_to_practice >=demand[j]; #Ograniczenie oznaczajace koniecznosc wylatania okreslonej liczby godzin.

solve;

display sum{j in months_to_plan_hiring}(sum{i in stewardess_status}(stewardess[i,j]*stewardess_wage[i]));
display {j in months_to_plan_hiring} stewardess['hired',j];
display {j in months_to_plan_hiring} stewardess['experienced',j];
display {j in months_to_plan_hiring} (stewardess['experienced',j]*maximal_amount_of_working_hours-stewardess['hired',j]*hours_to_practice);

