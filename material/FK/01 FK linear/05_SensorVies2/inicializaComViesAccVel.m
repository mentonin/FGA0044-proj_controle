T = 0.01;

Ad = [1 T;
      0 1];

Bd = [T^2/2;
      T];

C = [1 0
     0 1];

Ad_K = [1 T -T^2/2 0;
        0 1 -T     0;
        0 0  1     0;
        0 0  0     1];

Bd_K = [T^2/2;
        T;
        0;
        0];
  
Bd_n = [T^2/2  0    0;
        T      0    0;
        0      1    0
        0      0    1];

C_K = [1 0 0 0;
       0 1 0 1];
   
C_K1 = [1 0 0 0;
        0 1 0 0];  

    
