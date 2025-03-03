function result=ReturnFitness(fobj,xb,N)
    result=zeros(1,N);
    for i=1:N
        result(i)=fobj(xb(:,i)');
    end
end