function result =rfunccode(alpha,A,Farray) 
Ax=A(1);
Ay=A(2);
Az=A(3);
R0004=R000x(4,alpha,A,Farray);
R0005=R000x(5,alpha,A,Farray);
R0006=R000x(6,alpha,A,Farray);
R0007=R000x(7,alpha,A,Farray);

result =(3)*(((2)*(Az*(R0004))+Az*((R0004)+Az*(Az*(R0005))))+Ax*(Ax*((2)*(Az*(R0005))+Az*((R0005)+Az*(Az*(R0006))))))+Ax*((2)*(Ax*((2)*(Az*(R0005))+Az*((R0005)+Az*(Az*(R0006)))))+Ax*(((2)*(Az*(R0005))+Az*((R0005)+Az*(Az*(R0006))))+Ax*(Ax*((2)*(Az*(R0006))+Az*((R0006)+Az*(Az*(R0007)))))));