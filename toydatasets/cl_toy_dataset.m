function [ ds ] = cl_toy_dataset()

%%
mu = [0 0];
Sigma = [1 0; 0 1];
R = chol(Sigma);
c1 = repmat(mu,5000,1) + randn(5000,2)*R;

mu = [0 3.0];
Sigma = [0.5 0; 0 0.5];
R = chol(Sigma);
c2 = repmat(mu,1000,1) + randn(1000,2)*R;

mu = [0 -3.0];
Sigma = [.2 0; 0 .2];
R = chol(Sigma);
c3 = repmat(mu,200,1) + randn(200,2)*R;

mu = [4 0];
Sigma = [.2 -.1; -.1 .2];
R = chol(Sigma);
c4 = repmat(mu,100,1) + randn(100,2)*R;

mu = [-3.0 0];
Sigma = [.5 .4; .4 .5];
R = chol(Sigma);
c5 = repmat(mu,200,1) + randn(200,2)*R;

mu = [2 2];
Sigma = [.05 .0; .0 .05];
R = chol(Sigma);
c6 = repmat(mu,300,1) + randn(300,2)*R;


ds = [c1;c2;c3;c4;c5;c6];

end

