function [X,svp,idxbig] = FSVT(D, tau, Snum)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% min_{X} 1/2*||D-X||^2 + tau*||X||_tr.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%created by Fanhua Shang on 11/20/2016, fhshang@cse.cuhk.edu.hk

gap   = 5;
[m,n] = size(D);
ranks = min(m,n);
if min(m,n) <= 15
    if Snum <= round(ranks/2)+1
        [U, sigma, V] = svds(D, Snum, 'L');
    else
        [U, sigma, V] = svd(D, 'econ'); 
    end
    sigma = diag(sigma);
    svp   = length(find(sigma > tau)); 
    if svp >= 1 && svp < 6
        sigma = max(sigma(1:svp)-tau, 0);
        idxbig = [];
    elseif svp >= 6
        ratio = sigma(1:end-1)./sigma(2:end);
        idxstart = 5;
        idxbig = find(abs(ratio(idxstart:end)) > gap);   
        if ~isempty(idxbig)
            svp = (idxstart-1)+idxbig(1);
        else
            svp = length(find(sigma>tau));
        end
        sigma = max(sigma(1:svp)-tau, 0);
    else
        svp   = 1;
        sigma = 0;
        idxbig = [];
    end
    X = U(:,1:svp)*diag(sigma(1:svp))*V(:,1:svp)';
    return;
elseif 2.5*m < n
    DDT = D*D';
    if min(m,n)<=300
        % [U,Sigma,V] = mexsvd(DDT, 0); 
        [U,Sigma,V] = svds(DDT, 3);
    else
        [U,Sigma,V] = svds(DDT,Snum,'L');
    end  
    sigma = diag(Sigma);
    sigma = sqrt(sigma);
    tol1  = max([m,n])*eps(max(sigma));
    svp = sum(sigma > max(tol1, tau));
    if svp>=1 & svp < 6
        mid = max(sigma(1:svp)-tau,0)./sigma(1:svp);
        idxbig = [];
    elseif svp >= 6
        ratio = sigma(1:end-1)./sigma(2:end);
        idxstart = 5;
        idxbig = find(abs(ratio(idxstart:end))>gap);   
        if ~isempty(idxbig)
            svp = (idxstart-1)+idxbig(1);
        end
        mid = max(sigma(1:svp)-tau,0)./sigma(1:svp);
    else
        svp = 1;
        mid = 0;
        idxbig =[];
    end   
    X = U(:,1:svp)*diag(mid)*V(:,1:svp)'*D;
    return;
elseif m > 2.5*n
    [X, svp] = FSVT(D', tau, Snum);
    X = X';
    return;
else
    % DDT = D*D';     %ÐÂ¼Ó
    if min(m,n) <= 200
        % [U,Sigma,V] = mexsvd(DDT, 0);
        [U,Sigma,V] = svds(D, 3);
    else
        [U,Sigma,V] = svds(D, Snum, 'L');
    end
    sigma = diag(Sigma);
    tol1  = max([m,n])*eps(max(sigma));
    svp   = sum(sigma > max(tol1, tau));
    if svp >= 1  & svp < 6
        sigma = sigma(1:svp) - tau;
        idxbig = [];
    elseif svp >= 6    
        ratio = sigma(1:end-1)./sigma(2:end);
        idxstart = 5;
        idxbig = find(abs(ratio(idxstart:end)) > gap);   
        if ~isempty(idxbig)
            svp = (idxstart-1)+idxbig(1);
        end
        sigma = sigma(1:svp) - tau; 
    else
        svp   = 1;
        sigma = 0;
        idxbig = [];
    end
    X = U(:,1:svp)*diag(sigma(1:svp))*V(:,1:svp)';
end
end
