/******************************************************
	Author: Igor Dyczko 200477
******************************************************/

var x1 >= 0;  #Ilosc skladnika 1 wykorzystana do wytworzenia produktu A
var x2 >=0;   #Ilosc skladnika 2 wykorzystana do wytworzenia produktu A
var x3 >= 0;  #Ilosc skladnika 3 wykorzystana do wytworzenia produktu A
var x4 >=0;   #Ilosc skladnika 1 wykorzystana do wytworzenia produktu B
var x5 >= 0;  #Ilosc skladnika 2 wykorzystana do wytworzenia produktu B
var x6 >=0;   #Ilosc skladnika 3 wykorzystana do wytworzenia produktu B
var x7 >= 0;  #Ilosc skladnika 1 wykorzystana do wytworzenia produktu C
var x8 >=0;   #Ilosc odpadow skladnika 1 z procesu wytwarzania produktu A wykorzystana do wytworzenia produktu C
var x9 >= 0;  #Ilosc odpadow skladnika 2 z procesu wytwarzania produktu A wykorzystana do wytworzenia produktu C
var x10 >=0;  #Ilosc odpadow skladnika 3 z procesu wytwarzania produktu A wykorzystana do wytworzenia produktu C
var x11 >= 0; #Ilosc skladnika 2 wykorzystana do wytworzenia produktu D
var x12 >=0;  #Ilosc odpadow skladnika 1 z procesu wytwarzania produktu A wykorzystana do wytworzenia produktu D
var x13 >= 0; #Ilosc odpadow skladnika 2 z procesu wytwarzania produktu A wykorzystana do wytworzenia produktu D
var x14 >=0;  #Ilosc odpadow skladnika 3 z procesu wytwarzania produktu A wykorzystana do wytworzenia produktu D

/* Funkcja celu - maksymalizacja zysku, ktory obliczany jest przez dodanie wplywow ze sprzedazy produktow
 A, B, C oraz D oraz odjecie kosztow zakupu skladnikow oraz utylizacji odpadow z procesow wytwarzania 
poszczegolnych produktow*/

maximize  profit : (0.9*x1+0.8*x2+0.6*x3)*3+(0.8*x4+0.8*x5+0.5*x6)*2.5+(x7+x8+x9+x10)*0.6+(x11+x12+x13+x14)*0.5 -((x1+x4+x7)*2.1+(x2+x5+x11)*1.6+(x3+x6)*1.0)-((0.1*x1-x8)*0.1+(0.2*x2-x9)*0.1+(0.4*x3-x10)*0.2+ (0.2*x4-x12)*0.05+(0.2*x5-x13)*0.05+(0.5*x6-x14)*0.4);

#Zakres ilosci zakupionych skladnikow:
subject to ing1_min_resources: x1+x4+x7>=2000;
subject to ing1_max_resources: x1+x4+x7<=6000;
subject to ing2_min_resources: x2+x5+x11>=3000;
subject to ing2_max_resources: x2+x5+x11<=5000;
subject to ing3_min_resources: x3+x6>=4000;
subject to ing3_max_resources: x3+x6<=7000;

#Ograniczenia skladu produktu A:
s.t. ing1_for_productA: x1>=0.2*(x1+x2+x3);
s.t. ing2_for_productA: x2>=0.4*(x1+x2+x3);
s.t. ing3_for_productA: x3<=0.1*(x1+x2+x3);

#Ograniczenia skladu produktu B:
s.t. ing1_for_productB: x4>=0.1*(x4+x5+x6);
s.t. ing3_for_productB: x6<=0.3*(x4+x5+x6);

#Ograniczenia odpadow wykorzystanych do wytworzenia produktu C:
s.t. leftover_from_ing1_productA: x8<=0.1*x1;
s.t. leftover_from_ing2_productA: x9<=0.2*x2;
s.t. leftover_from_ing3_productA: x10<=0.4*x3;

#Ograniczenia odpadow wykorzystanych do wytworzenia produktu D:
s.t. leftover_from_ing1_productB: x12<=0.2*x4;
s.t. leftover_from_ing2_productB: x13<=0.2*x5;
s.t. leftover_from_ing3_productB: x14<=0.5*x6;

#Ograniczenie zawartosci skladnika 1 w produkcie C:
s.t. ing1_for_productC: x7=0.2*(x7+x8+x9+x10);

#Ograniczenie zawartosci skladnika 2 w produkcie D:
s.t. ing2_for_productD: x11=0.3*(x11+x12+x13+x14);
 
solve;

display (0.9*x1+0.8*x2+0.6*x3)*3+(0.8*x4+0.8*x5+0.5*x6)*2.5+(x7+x8+x9+x10)*0.6+(x11+x12+x13+x14)*0.5 -((x1+x4+x7)*2.1+(x2+x5+x11)*1.6+(x3+x6)*1.0)-((0.1*x1-x8)*0.1+(0.2*x2-x9)*0.1+(0.4*x3-x10)*0.2+ (0.2*x4-x12)*0.05+(0.2*x5-x13)*0.05+(0.5*x6-x14)*0.4);
display x1+x4+x7;
display x2+x5+x11;
display x3+x6;
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
display x1*0.1-x8;
display 0.2*x2-x9;
display x3*0.4-x10;
display x4*0.2-x12;
display x5*0.2-x13;
display x6*0.5-x14;

