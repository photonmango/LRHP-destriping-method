%   Distribution code Version 1.0 -- 06/30/2018 by Xinxin Liu Copyright 2018.
%
%   The Code is created based on the method described in the following paper 
%   [1] X. Liu, H. Shen, Q. Yuan, X. Lu, C. Zhou, “A Universal Destriping 
%       Framework Combining 1D and 2D Variational Optimization Methods,” 
%       IEEE TGRS, vol.56, no.2, pp.808-822, 2018.
%
%   The code and the algorithm are for non-comercial use only.
function  [G] = ProfileSmooth(I,p,lambda)    %%%我修改后的
% function  [ME,A] = ProfileSmooth(I,p,lambda)
%
% Solve  min_G\  1/p*||G-C||_p + lambda/2*||D*G||_2
% using iteratively reweighted norm approach
%
% ME: Smoothed profile to guide destriping(matrix version)
% A: a template used to calculate the mean profile
% I: input image (should be a gray-scale/single channel image)
% p: p-norm, 1 for sparse case, 2 for dense case
% lambda: regularization parameter

% ==================
%  Initialization
% ==================
C = mean(I,2);    % mean profile of the noisy image
maxiter = 50;     % the max iteration number
tol = 1e-5;       % parameter for stopping the iteration
print = 1;        % wheather plot the results or not, 1 yes ,0 not  
n  = length(C);   % the length of the profile
ep = 1e-5;        % small positive value guarantees the global convergence

% to construct the second order difference matrix
E = speye(n,n);
E2  = speye(n-2,n-2);
O2 = zeros(n-2,1);
D = [E2 O2 O2]+[O2 -2*E2 O2]+[O2 O2 E2]; 
DTD = D'*D;

hisfval = [];
G = (E + lambda*DTD)\C;  % Smoothed profile to guide destriping

%% Main loop
rc = tol + 1;    % to make the main loop going on 
iter = 0;        % to count the steps used in the main loop 

while rc >= tol && iter<= maxiter
    iter = iter+1;
    Gp = G;
    
    % =========================
    %   W Matrix Construction
    % =========================
    W = abs(G - C);
    W(W(:) < ep) = ep;
    W = W.^(p-2);
    W = spdiags(W,0,n,n);
         
    % ==================
    %    G-subprolem
    % ==================
    G = (W + lambda*DTD)\(W*C);
    rc = norm(G - Gp,'fro')/norm(G,'fro');
    
    % ==================
    %    Curve-Plot
    % ==================
%     if print
%         figure(1);
%         hold off
%         plot(C,...
%             'color',[0,1,0],...
%             'LineStyle','--'); 
%         hold on
%         plot(G,...
%             'color',[1,0,0],...
%             'LineStyle','-');
%         
%     end
end
%%%下面的我都注释掉了 不需要ME和A
% e = ones(1,size(I,2));  % with size 1*m 
% % to transform the n*1 profile into a n*m matrix with the same value in a row
% ME = G*e;               
% A = 1/size(I,2) * e;        

end