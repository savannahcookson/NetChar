function directionalp = permP(permMat,realMat,alpha)

posmat = permMat < realMat;
%negmat = permMat > realMat;

posp = mean(posmat,3);
%negp = mean(negmat,3);

posthresh = posp > (1-alpha);
%negthresh = negp > (1-alpha);

directionalp = posthresh;% + (-1*negthresh);

end