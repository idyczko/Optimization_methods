
set products1;
set products2;
set waste;
set ingredients;
param cost{ingredients};

var products1_constitution{products1, ingredients}>=0;
var products2_constitution{ingredients_for_C}>=0;
var productD_constitution{ingredients_for_D}>=0;

var x1 >= 0;/* How much of ingedients 1,2,3 was used*/
var x2 >=0;/* to create product A*/
var x3 >= 0;
var x4 >=0;/*prod 2*/
var x5 >= 0;
var x6 >=0;
var x7 >= 0;/*how much ing1 and wastes to create C*/
var x8 >=0;
var x9 >= 0;
var x10 >=0;
var x11 >= 0;/*how much ing 2 and wastes to create D*/
var x12 >=0;
var x13 >= 0;
var x14 >=0;


/* Objective function */
maximize  profit : sum{j in products1}(sum{i in ingredients}(products1_constitution[j][i]*(1-leftovers[j][i]))*product_price[j]) (x7+x8+x9+x10)*0.6+(x11+x12+x13+x14)*0.5 -((x1+x4+x7)*2.1+(x2+x5+x11)*1.6+(x3+x6)*1.0)-((0.1*x1-x8)*0.1+(0.2*x2-x9)*0.1+(0.4*x3-x10)*0.2+ (0.2*x4-x12)*0.05+(0.2*x5-x13)*0.05+(0.5*x6-x14)*0.4);
/* Constraints */

subject to ing1_min_resources: x1+x4+x7>=2000;
subject to ing1_max_resources: x1+x4+x7<=6000;
subject to ing2_min_resources: x2+x5+x11>=3000;
subject to ing2_max_resources: x2+x5+x11<=5000;
subject to ing3_min_resources: x3+x6>=4000;
subject to ing3_max_resources: x3+x6<=7000;
s.t. ing1_for_productA: x1>=0.2*(x1+x2+x3);
s.t. ing2_for_productA: x2>=0.4*(x1+x2+x3);
s.t. ing3_for_productA: x3<=0.1*(x1+x2+x3);
s.t. ing1_for_productB: x4>=0.1*(x4+x5+x6);
s.t. ing3_for_productB: x6<=0.3*(x4+x5+x6);
s.t. leftover_from_ing1_productA: x8<=0.1*x1;
s.t. leftover_from_ing2_productA: x9<=0.2*x2;
s.t. leftover_from_ing3_productA: x10<=0.4*x3;
s.t. leftover_from_ing1_productB: x12<=0.2*x4;
s.t. leftover_from_ing2_productB: x13<=0.2*x5;
s.t. leftover_from_ing3_productB: x14<=0.5*x6;
s.t. ing1_for_productC: x7=0.2*(x7+x8+x9+x10);
s.t. ing2_for_productD: x11=0.3*(x11+x12+x13+x14);


 
solve;

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

data;
set ingredients:= ing1 ing2 ing3;
set products1 := A B 
set products2 := C D;
set wasteA:= wasteA1 wasteA2 wasteA3;
set wasteB:= wasteB1 wasteB2 wasteB3;
set ingredients_for_C:= ing1 wasteA1 wasteA2 wasteA3;
set ingredients_for_D:= ing2 wasteB1 wasteB2 wasteB3;
param cost:= ing1 2.1 ing2 1.6 ing3 1.0;
param product_price:= A 3 B 2.5 C 0.6 D 0.5;
param max_ing:= ing1 6000 ing2 5000 ing3 7000;
param min_ing:= ing1 2000 ing2 3000 ing3 4000;
param leftovers: A B:=
	ing1 0.1 0.2
	ing2 0.2 0.2
	ing3 0.4 0.5;
param util_cost: A B:=
	ing1 0.1 0.05
	ing2 0.1 0.05
	ing3 0.2 0.4; 
end;

