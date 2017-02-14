function r = ratioClassifier(posx,negx,samples_feature,M)
%%modified
[row,col] = size(samples_feature);
mu1 = posx.mu;
sig1= posx.sig;
mu0 = negx.mu;
sig0= negx.sig;

mu1  = repmat(mu1,1,col);
sig1 = repmat(sig1,1,col);
mu0  = repmat(mu0,1,col);
sig0 = repmat(sig0,1,col);

n0= 1./(sig0+eps);
n1= 1./(sig1+eps);
e1= -1./(2*sig1.^2+eps);
e0= -1./(2*sig0.^2+eps);

x = samples_feature;
p0 = exp((x-mu0).^2.*e0).*n0;
p1 = exp((x-mu1).^2.*e1).*n1;

r  = (log(eps+p1)-log(eps+p0));

