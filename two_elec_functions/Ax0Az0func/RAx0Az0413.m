function result =rfunccode(alpha,A,Farray) 
Ax=A(1);
Ay=A(2);
Az=A(3);
R0005=R000x(5,alpha,A,Farray);
R0006=R000x(6,alpha,A,Farray);
R0007=R000x(7,alpha,A,Farray);

result =(3)*((Ay*((2)*(Az*(R0005))+Az*((R0005)+Az*(Az*(R0006)))))+Ax*(Ax*(Ay*((2)*(Az*(R0006))+Az*((R0006)+Az*(Az*(R0007)))))));