function clean_HSI = LRHP_destripe(Y,param)

p = param.p;             
lambda1 = param.lambda1;   
lambda2 = param.lambda2; 
beta = param.beta;
lambda_gp = param.lambda_gp;

eps = param.eps;
MaxIter = param.MaxIter; 


[M,N,B]=size(Y);
%%% Normalization
MaxPixVal = max(max(max(Y)));
Y = Y./MaxPixVal;

%%%guided profile 相关参数
% direction=1;    %使用于M3所以direction为1
g_Y=zeros(M,1,B);

%%% Initialization for variables
H=reshape(Y,M*N,B); %%%原始影像的二维字典展开
X=Y;
S=zeros(M,N,B);

u=0.001;
u_max=1e07; 
rho=1.5;

J1=zeros(M,N,B);

%%% Initialization for low rank
svp_h=6;
svp_s=2.*ones(B,1);
rlnc=6;

%%% threshold
rank1=10;
rank2=10;
%%% calculate guided profile g_Y
f=1.0/N.*ones(N,1);   

for i=1:B
   [g_Y(:,:,i)]=ProfileSmooth(Y(:,:,i),p,lambda_gp);
end

%%% loop
k=0;    
tic
while k<MaxIter
    k=k+1;
%    Upadate X and S
H2=reshape(H,M,N,B);
Hp=H;
for i=1:B 
    X(:,:,i)=(2.*lambda2.*g_Y(:,:,i)*f'+beta.*Y(:,:,i)-beta.*S(:,:,i)+u.*H2(:,:,i)+J1(:,:,i))./(2*lambda2)...
                 /(f*f'+(0.5*beta/lambda2+0.5*u/lambda2).*eye(N));
    [S(:,:,i),svp_s(i,1)]=FSVT(Y(:,:,i)-X(:,:,i),lambda1/beta,svp_s(i,1));
    svp_s(i,1)=min(svp_s(i,1)+rlnc,rank2);
end
    
%    Update H
    X2=reshape(X,M*N,B);
    J2=reshape(J1,M*N,B);
    [H,svp_h]=FSVT(X2-J2./u,1.0/u,svp_h);   
    svp_h=min(svp_h+rlnc,rank1);
    
%   Update Lagrange multiplier J1
    J1=J1+u.*(H2-X);
    

% %  whether reach the convergence 
    stopC = norm(H - Hp,'fro')/norm(H,'fro');
    if stopC < eps
        break;
    else
%   Update parameter
        u=min(rho*u,u_max);
        fprintf('Iter: %d, difference: %6.4e\n',k,stopC);
    end 
end
toc
disp(['total time: ',num2str(toc)]);

clean_HSI=X.*MaxPixVal;




