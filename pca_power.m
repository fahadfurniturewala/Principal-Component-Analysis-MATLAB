function pca_power( a,b,c,d )
train=importdata(a);
test=importdata(b);
A=train(:,1:end-1);
B=test(:,1:end-1);
M=str2num(c);
iter=str2num(d);
[m,n]=size(train);
[tm,tn]=size(test);
bs=zeros(n-1,M);
for i=1:M
    S=cov(A);
    b=ones(n-1,1);
    for j=1:iter
        temp=S*b;
        temp_len=length(temp);
        nor=0.00;
        for k=1:temp_len
            nor=nor+(temp(k,1).^2);
        end
        nor=nor.^(1/2);
        for k=1:n-1
            b(k,1)=temp(k,1)/nor;
        end
    end
    bs(:,i)=b;
    for j=1:m
        A(j,:)=A(j,:)-(b'*A(j,:)'*b');
    end  
    fprintf('Eigenvector %d\n',i);
    for j=1:n-1
        fprintf('%3d : %.4f\n',j,bs(j,i));
    end
end
for i=1:tm
    fprintf('Test Object %5d\n',i-1);
    for j=1:M
        temp=bs(:,j)'*B(i,:)';
        fprintf('%3d : %.4f\n',j,temp);
    end
end
end