function result =rfunccode(alpha,A,Farray) 
Ax=A(1);
Ay=A(2);
Az=A(3);
R0005=R000x(5,alpha,A,Farray);
R0006=R000x(6,alpha,A,Farray);
R0007=R000x(7,alpha,A,Farray);

result =(2)*(Ax*((2)*(Ay*((R0005)+Az*(Az*(R0006))))+Ay*(((R0005)+Az*(Az*(R0006)))+Ay*(Ay*((R0006)+Az*(Az*(R0007)))))));