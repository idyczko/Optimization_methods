/******************************************************
	Autor: Igor Dyczko 200477
******************************************************/

param problem_size; # Rozmiar macierzy Hilberta.

set range:=1..problem_size; # Zakres wierszy i kolumn.

param x_ref{i in range}:=1; # Rozwiązanie optymalne zagadnienia optymalizacji.
param A{i in range, j in range}:=1/(i+j-1); # Obliczanie wartości elementów macierzy Hilberta.
param c{i in range}:=sum{j in range}(1/(i+j-1)); # Funkcja kosztu.
param b{i in range}:=sum{j in range}(1/(i+j-1)); # Wektor prawych stron.

var x{range}>= 0; #Zmienna decyzyjna.

minimize cost_function: sum{i in range}(c[i]*x[i]); #Minimalizacja funkcji celu.
s.t. constraint{i in range}: sum{j in range}(A[i,j]*x[j])=b[i]; #Ograniczenie.

solve;

display ((sum{i in range}((x_ref[i]-x[i])^2))^(1/2))/(sum{i in range}(x_ref[i]^2))^(1/2); #Wyswietlenie bledu wzglednego rozwiazania.
