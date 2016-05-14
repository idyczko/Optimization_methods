/******************************************************
	Author: Igor Dyczko 200477
******************************************************/

#Zmienne binarne oznaczajace czy dana grupa cwiczeniowa zostanie wybrana czy nie.
#Algebra:
var x1 binary;
var x2 binary;
var x3 binary;
var x4 binary;

#Analiza:
var x5 binary;
var x6 binary;
var x7 binary;
var x8 binary;

#Fizyka:
var x9 binary;
var x10 binary;
var x11 binary;
var x12 binary;

#Chemia mineraliow:
var x13 binary;
var x14 binary;
var x15 binary;
var x16 binary;

#Chemia organiczna:
var x17 binary;
var x18 binary;
var x19 binary;
var x20 binary;

#Mozliwe terminy obiadow w stolowce:
#Poniedzialek:
var caf1 binary;
var caf2 binary;
var caf3 binary;

#Wtorek:
var caf4 binary;
var caf5 binary;
var caf6 binary;

#Sroda:
var caf7 binary;
var caf8 binary;
var caf9 binary;

#Czwartek:
var caf10 binary;
var caf11 binary;
var caf12 binary;

#Piatek:
var caf13 binary;
var caf14 binary;
var caf15 binary;

#Mozliwe terminy zajec sportowych:
var sport1 binary;
var sport2 binary;
var sport3 binary;

#Funkcja celu oznaczajaca zadowolenie studenta. Suma iloczynow zmiennych decyzyjnych i opdowiadajacych im wartosci preferencji:
maximize satisfation: 5*x1+4*x2+10*x3+5*x4+4*x5+4*x6+5*x7+6*x8+3*x9+5*x10+7*x11+8*x12+10*x13+10*x14+7*x15+5*x16+0*x17+5*x18+3*x19+4*x20;

#Koniecznosc zapisania sie na jedna grupe kazdego kursu:
s.t. one_choice_per_course_algebra: x1+x2+x3+x4=1;
s.t. one_choice_per_course_analisys: x5+x6+x7+x8=1;
s.t. one_choice_per_course_physics: x9+x10+x11+x12=1;
s.t. one_choice_per_course_orgchem: x13+x14+x15+x16=1;
s.t. one_choice_per_course_minchem: x17+x18+x19+x20=1; 

#Mniej niz 4 godziny zajec dziennie:
s.t. no_more_than_4_hours_on_monday: 2*x1+2*x5+2*x13+2*x14+1.5*x17+1.5*x18<=4;
s.t. no_more_than_4_hours_on_tuesday: 2*x2+2*x6+3*x9+3*x10<=4;
s.t. no_more_than_4_hours_on_wednesday: 2*x3+2*x4+2*x7<=4;
s.t. no_more_than_4_hours_on_thursday: 2*x8+3*x11+3*x12+2*x15<=4;
s.t. no_more_than_4_hours_on_friday: 2*x16+1.5*x19+1.5*x20<=4;

#Ograniczenia wykluczajace obecnosc na zajeciach, ktorych czas trwania sie pokrywa z uwzglednieniem zajec sportowych oraz obiadu na stolowce:
s.t. monday_constraint_1: sport1+x1+x5+caf2+caf3<=1;
s.t. monday_constraint_2: x13+x14+x17<=1;
s.t. tuesday_constraint_1: x2+x6+x9+x10<=1;
s.t. tuesday_constraint_2: caf4+x10<=1;
s.t. wednesday_constraint_1: x3+x4+x7+sport2<=1;
s.t. wednesday_constraint_2: x4+x7+caf7+caf8<=1;
s.t. wednesday_constraint_3: sport3+caf8+caf9<=1;
s.t. thursday_constraint_1: x15+caf11+caf12<=1;
s.t. thursday_constraint_2: x11+x12<=1;
s.t. friday_constraint_1: caf14+caf15+x16+x20<=1;
s.t. friday_constraint_2: caf13+x19<=1;

#Godzina dziennie na obiad w okreslonych godzinach otwarcia stolowki:
s.t. one_hour_meal_on_monday: caf1+caf2+caf3=1;
s.t. one_hour_meal_on_tuesday: caf4+caf5+caf6=1;
s.t. one_hour_meal_on_wednesday: caf7+caf8+caf9=1;
s.t. one_hour_meal_on_thursday: caf10+caf11+caf12=1;
s.t. one_hour_meal_on_friday: caf13+caf14+caf15=1;

#Trenowanie ulubionej dyscypliny sportowej:
s.t. trainings: sport1+sport2+sport3>=1;

#Tylko 3 dni cwiczen w tygodniu przy wskazniku preferencji nie mniejszym niz 5:
s.t. only_three_days: x3+x4+x7+x16+x19+x20=0;
s.t.  not_less_than_5: x2+x5+x6+x9+x17+x19+x20=0;
solve;

display 5*x1+4*x2+10*x3+5*x4+4*x5+4*x6+5*x7+6*x8+3*x9+5*x10+7*x11+8*x12+10*x13+10*x14+7*x15+5*x16+0*x17+5*x18+3*x19+4*x20;
display x1;
display x2;
display x3;
display x4;
display x5;
display x6;
display x7;
display x8;
display x9;
display x10;
display x11;
display x12;
display x13;
display x14;
display x15;
display x16;
display x17;
display x18;
display x19;
display x20;

display caf1;
display caf2;
display caf3;
display caf4;
display caf5;
display caf6;
display caf7;
display caf8;
display caf9;
display caf10;
display caf11;
display caf12;
display caf13;
display caf14;
display caf15;

display sport1;
display sport2;
display sport3;
