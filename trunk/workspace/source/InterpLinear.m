function x = InterpLinear(x1,y1,x2,y2,y)

  %x1, // componente x do ponto 1
  %y1, // componente y do ponto 1
  %x2, // componente x do ponto 2
  %y2, // componente y do ponto 2
  %y // componente y do ponto intermediario


  %a; // coeficiente angular da reta que passa pelos pontos 1 e 2
  %b; // termo independente da reta que passa pelos pontos 1 e 2
  %aux_x, aux_y; // variaveis auxiliares
  %x; // valor de retorno da funcao

  aux_x = x1 - x2;
  aux_y = y1 - y2;

  a = aux_y / aux_x;
  b = y1-a*x1;

  x = (y - b)/a;
