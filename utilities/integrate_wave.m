    
function psi = integrate_wave(xvals,yvals,zvals,d,c,spreads,shapematrix,centers,K,L,orbit)

 
 
psi=zeros(length(xvals),length(yvals),length(zvals));
         x = xvals ;
            y = yvals;
                z= zvals ;
     [x3d,y3d,z3d]=meshgrid(x,y,z);
                
             for mu=1:K%����ѡ���˵� ԭ��
        shape=  shapematrix(mu,:);
        xl=shape(1);
        ym=shape(2);
        zn=shape(3);
                for p=1:L % ��������һ��STO��Ӧ�ĸ�˹����
                    xA = centers(mu,1);
                    yA = centers(mu,2);
                    zA = centers(mu,3);
                                   
                    alpha = spreads(p,mu);
                    
        psi = psi +   d(p,mu)*c(mu,orbit)*(x3d-xA).^xl.*(y3d-yA).^ym.*(z3d-zA).^zn.*exp(-alpha*(x3d-xA).^2).*exp(-alpha*(y3d-yA).^2).*exp(-alpha*(z3d-zA).^2);     
                     
                end
             end
 
end