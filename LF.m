function result=LF
    beta=1.5;
    u=rand;
    v=rand;
    sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);
    result=0.01*u*sigma/(abs(v)^(1/beta));
end