function result =rfunccode(alpha,A,Farray) 
Ax=A(1);
Ay=A(2);
Az=A(3);
R0002=R000x(2,alpha,A,Farray);
R0003=R000x(3,alpha,A,Farray);

result =(Az*(R0002))+Ax*(Ax*(Az*(R0003)));