A = [0 1;0 0];
B = [0 1]';
C = [1 0];
T = 0.01;

G_cont = ss(A,B,C,0);
G_disc = c2d(G_cont,T);

Ad = G_disc.a;
Bd = G_disc.b;

    
