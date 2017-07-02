function energy = myCO_func(R)
%*****************************************************************************
%     <Hatree fock solution of Carbon monoxide>
%     Copyright (C) <2014>  <X fan@ Clarkson Univ>
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.
%*****************************************************************************
% RHF������H2���ӣ��������� http://www.cchem.berkeley.edu/chem195/globals.html��
% �޸��˴󲿷�.�����д��������s��f��״�ĸ���
% cartesian guassian function�Ļ�����
%*****************************************************************************
 %  
 
%      R=2.07;
deletelimit=0;
    K=10; % ��Ϊ����С���飬�����=slater������.
    L=2; % Lָ����ÿ��slater �����L����˹�������
        %�õ���STO-2G���飬������˹������� 1��Slater����
    
    Nelec=14; % number of electrons
    Nnuc=2;   % number of nuclei
    
    nucchg = [6 8]; % nuclear charge
    
    spreads = zeros(L,K);  % ��˹����ָ������
    d = zeros(L,K);        % STO=d1*gaussian 1+d2*gaussian 2. d�����������GTO���STO�����Ǳ���
    centers = zeros(L,K,3);% centers of each primitive Gaussian
    shapematrix = zeros(L,K,3);
    % alphas were calculated by linear fitting to Gaussian functions to
    % Slater-type functions
    

        %��https://bse.pnl.gov/bse/portal������STO-2G


    spreads(1,1) =27.38503303;
    spreads(2,1) =4.874522075 ; 
    
      spreads(1,2:5) =1.136748198;
     spreads(2,2:5) =0.2883093603 ;
     
        spreads(1,6) =49.98097117;
    spreads(2,6) =8.896587673; 
      spreads(1,7:10) =1.945236531;
     spreads(2,7:10) =0.4933633506 ; 
     
    %P���
    shapematrix(1,3,:) = [1,0,0];
    shapematrix(2,3,:) = [1,0,0];
    shapematrix(1,4,:) = [0,1,0];
    shapematrix(2,4,:) = [0,1,0];
    shapematrix(1,5,:) = [0,0,1];
    shapematrix(2,5,:) = [0,0,1];
    
        shapematrix(1,8,:) = [1,0,0];
    shapematrix(2,8,:) = [1,0,0];
    shapematrix(1,9,:) = [0,1,0];
    shapematrix(2,9,:) = [0,1,0];
    shapematrix(1,10,:) = [0,0,1];
    shapematrix(2,10,:) = [0,0,1];
    %c no 1s 
d(1,1) =  0.4301284983 ; %d(L,K). L is the # for contration of gaussian, K mean the orbit #
d(2,1) =  0.6789135305;
   % C�� 2s 2p
d(1,2) =  0.04947176920  ;
d(2,2) =  0.9637824081;
d(1,3:5) =  0.5115407076 ;
d(2,3:5) = 0.6128198961;

%O��1s ��
d(1,6) = 0.4301284983;
d(2,6) = 0.6789135305;
%O de 2s2p
d(1,7) = 0.04947176920;
d(2,7) = 0.9637824081;
d(1,8:10) = 0.5115407076;
d(2,8:10) =0.6128198961;

% Դcode �����������һ��ϵ����û������������Ǵ�ġ�
 d=d.*(2*spreads/pi).^0.75;
 d(:,3:5)=  d(:,3:5).*spreads(:,3:5).^0.5*2;
  d(:,8:10)=  d(:,8:10).*spreads(:,8:10).^0.5*2;
    % ԭ�Ӻ�λ��

    Rnuc = zeros(Nnuc,3);
    Rnuc(1,1) =  0;
    Rnuc(1,2) =  0;
     Rnuc(1,3) =  0;
    Rnuc(2,1) = 0;
    Rnuc(2,2) = 0;  % H F ���
   Rnuc(2,3) = R; 
    
    % ��ÿ������趨λ�� % zhuyi!!!! !!!!!!!!!!
    centers(:,1:5,1) = Rnuc(1,1);%center����ɹ���ĸ�˹������ţ������ţ�xyz���꣩
    centers(:,1:5,2) = Rnuc(1,2);
     centers(:,1:5,3) = Rnuc(1,3);
    % Center the 1s basis element for hydrogen #2:
    centers(:,6:10,1) =  Rnuc(2,1);
    centers(:,6:10,2) =  Rnuc(2,2);
    centers(:,6:10,3) =  Rnuc(2,3);
    
    % F is located in the center
%     centers(1,2,1) = Rnuc(2,1);
%     centers(2,2,1) = Rnuc(2,1);
%     centers(1,3,2) = Rnuc(2,2);
%     centers(2,3,2) = Rnuc(2,2);
%     centers(1,4,1) = Rnuc(2,1);
%     centers(2,4,1) = Rnuc(2,1);
%     centers(1,5,2) = Rnuc(2,2);
%     centers(2,5,2) = Rnuc(2,2);
%     centers(1,6,1) = Rnuc(2,1);
%     centers(2,6,1) = Rnuc(2,1);


    %%
    % ���hatree-fock���̸��������ֵ��������
    S = zeros(K,K);%S����
    T = zeros(K,K);%T����
    V = zeros(K,K);%V����
    flag2 = zeros(K,K); %��flag
    
    %Calculate the parts of the Fock matrix hamiltonian:
       
    for mu=1:K    % ��ÿ�����
        for nu = 1:K       % ����һ�������һ����ɵĸ�˹���������
            if flag2(mu,nu)==0
               for p=1:L                % ��ÿ���������ɸ�˹����
                    for q=1:L         
                    
                    RA = [centers(p,mu,1) centers(p,mu,2) centers(p,mu,3)];
                    RB = [centers(q,nu,1) centers(q,nu,2) centers(q,nu,3)];
                    alpha = spreads(p,mu);
                    beta = spreads(q,nu);
                    
                    S(mu,nu) = S(mu,nu) + d(p,mu)*d(q,nu)*...
                       myoverlap3(alpha,beta,shapematrix(p,mu,:),shapematrix(q,nu,:),RA,RB );
                    
                    T(mu,nu) = T(mu,nu) + d(p,mu)*d(q,nu)*...
                       mykinetic(alpha,beta,shapematrix(p,mu,:),shapematrix(q,nu,:),RA,RB );
             
                         
                    for i=1:Nnuc
                        RC = Rnuc(i,:);
                         V(mu,nu) = V(mu,nu) + d(p,mu)*d(q,nu)*...
                            nucchg(i)*mynuc_elec3(alpha,beta,shapematrix(p,mu,:),shapematrix(q,nu,:),RA,RB,RC);
                    end
                  
                   end
               end
               % ɾ������С�Ļ���
                  if abs(T(mu,nu))<deletelimit
                        T(mu,nu)=0;
                  end
                  if abs(V(mu,nu))<deletelimit
                        V(mu,nu)=0;
                  end
                  if abs(S(mu,nu))<deletelimit
                        S(mu,nu)=0;
                  end
                %ǿ�ƶԳ��ԣ�����
                S(nu,mu)=S(mu,nu);
                T(nu,mu)=T(mu,nu);
                V(nu,mu)=V(mu,nu);
                flag2(mu,nu)=1;
                flag2(nu,mu)=1;
            end
        end
    end
 
    %%
    % Two-electron matrix elements
    % Calculate eq 3.211 w/ primitive Gaussians 3.212:
    %4D���󴢴������ģ������ӻ���
    two_elec = zeros(K,K,K,K);
     flag= zeros(K,K,K,K);% flag �Ǳ���ģ��ж��Ƿ���Ҫ���¼���˫���ӻ���
    %����ÿ�������ÿ����˹�������� ��Ϊ�ǻ��ֽ���� �ĸ� ��˹������ ��أ���Ҫ�����Ĵ�
    tic
    for mu=1:K
        for nu=1:K
            for lambda=1:K
                for sigma=1:K
             if flag(mu,nu,lambda,sigma)==0   
                 label =0;
                     for p=1:L
                         for q=1:L
                            for s=1:L
                                for t=1:L
                         if label==1
                              two_elec(mu,nu,lambda,sigma) =0;
                         else
                                   
       RA = [centers(p,mu,1) centers(p,mu,2) centers(p,mu,3)];
       RB = [centers(q,nu,1) centers(q,nu,2) centers(q,nu,3)];
       RC = [centers(s,lambda,1) centers(s,lambda,2) centers(s,lambda,3)];
       RD = [centers(t,sigma,1) centers(t,sigma,2) centers(t,sigma,3)];
       
       alpha = spreads(p,mu);
       beta = spreads(q,nu);
       gamma = spreads(s,lambda);
       delta = spreads(t,sigma);
        Resultmyelec=  myelec_elec3(alpha,beta,gamma,delta,shapematrix(p,mu,:),shapematrix(q,nu,:),shapematrix(s,lambda,:),shapematrix(t,sigma,:),RA,RB,RC,RD);
       if Resultmyelec==0
           label=1;
       end
        result=d(p,mu)*d(q,nu)*d(s,lambda)*d(t,sigma)*Resultmyelec;
       two_elec(mu,nu,lambda,sigma) = two_elec(mu,nu,lambda,sigma) + result;
                         end
                                end
                            end
                        end
                    end
                    
                    
                    if abs(two_elec(mu,nu,lambda,sigma))<1e-16
                         two_elec(mu,nu,lambda,sigma)=0;
                    end
                    
       	two_elec(nu,mu,lambda,sigma)=two_elec(mu,nu,lambda,sigma);
        two_elec(nu,mu,sigma,lambda)=two_elec(mu,nu,lambda,sigma);
         two_elec(mu,nu,sigma,lambda)=two_elec(mu,nu,lambda,sigma);
       two_elec(sigma,lambda,mu,nu )=two_elec(mu,nu,lambda,sigma);
       two_elec(lambda,sigma,mu,nu )=two_elec(mu,nu,lambda,sigma);
        two_elec(sigma,lambda,nu,mu )=two_elec(mu,nu,lambda,sigma);
         two_elec(lambda,sigma,nu,mu )=two_elec(mu,nu,lambda,sigma);
         
         flag(nu,mu,lambda,sigma)=1;
        flag(nu,mu,sigma,lambda)=1;
         flag(mu,nu,sigma,lambda)=1;
       flag(sigma,lambda,mu,nu )=1;
       flag(lambda,sigma,mu,nu )=1;
        flag(sigma,lambda,nu,mu )=1;
         flag(lambda,sigma,nu,mu )=1;
             end
             
                end
            end
         
        end
      
    end
    
toc
       %%
 % �������������ԵĶ���
    [orbs,Dorbs]=eig(S);
    [orbs,Dorbs] = sorteig(orbs,Dorbs);    
    X=zeros(size(orbs));
    Y=X; %Ԥ�����ܶȾ������
        for i=1:K
        X(:,i)=orbs(:,i)/(Dorbs(i,i)^0.5);
        Y(:,i)=orbs(:,i)/(Dorbs(i,i) );
        end
     
    %������ ��Roothaan ���̣����������� SCF
    %�� F*C(i)=D(i)*S*C(i) , Roothaan equations
 
    %D��Ӧÿ����������ӻ��ܣ�c�ǹ��
 
      

    %F��C�ĺ���������Ҫ����
    clear Pold
   it=0;
   deltaE=1;
 while it<40
     it=it+1;
%         step
        if it==1
        % �ܶȾ������
        %����һ���ò������Ӽ��ų�����F�������c
     H=T+V; 
    Hprime=X'*H*X;
%     
    [cprime,D] = eig(Hprime);
     [cprime,D] = sorteig(cprime,D);
      c=X*cprime;  
        P = zeros(K,K); 
       for i=1:Nelec/2
            P=P+2*(c(:,i)*c(:,i)');
       end
        %��������gauss 
%              P=Pg;

        else 
%         P = zeros(K,K); 
        P = zeros(K,K); 
       for i=1:Nelec/2
            P=P+2*(c(:,i)*c(:,i)');
       end
       end
    % 
 % �ܶȷ��̻�� density matrix mixing!
          Pnew=P;
        if it >1
                P=Pnew*0.5+Pold*0.5 ;%�ܶȻ�Ͽ��Է�ֹ���ָ����Ĺ��������������                   
       end
          % Calculate the G(mu,nu) part of the Fock matrix, (eq 3.154)
        
        G=zeros(K,K);
        
        for mu=1:K
            for nu=1:K
                for lambda=1:K
                    for sigma=1:K
                        G(mu,nu) = G(mu,nu) + ...
                   P(lambda,sigma)*( two_elec(mu,nu,sigma,lambda)...
                            - 0.5*two_elec(mu,lambda,sigma,nu) );
                        if abs(G(mu,nu))<deletelimit
                            G(mu,nu)=0;
                        end
                    end
                end
            end
         end
F=G+H;          
          Fprime=X'*F*X;
        % ��������
        [cprime,D] = eig(Fprime);
        [cprime,D] = sorteig(cprime,D);    
%        D=real(D);
%          cprime=real(cprime);
     c=X*cprime;  
     
%          [c,D] = eig(S\F); 
%     [c,D] = sorteig(c,D);   
        
        energy=0.5*sum(sum(P.*G))+sum(sum(P.*(T+V)));
        % ԭ�Ӻ˼����
         internucEnergy = 6*8/R;
        energy = energy + internucEnergy ; %  
         
 if it>2
     deltaE=energyold-energy;

 end
 if abs(deltaE)<1e-11
         break
 end
       
    energyold=energy;
 Pold=P;
  
   
end
it 
deltaE
 energy