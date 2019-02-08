function [ ds ] = cl_toy_dataset2()

%%
mu = [3 2];
Sigma = [.05 .0; .0 .05];
R = chol(Sigma);
c1 = repmat(mu,300,1) + randn(300,2)*R;

mu = [4 3];
Sigma = [.05 .0; .0 .05];
R = chol(Sigma);
c2 = repmat(mu,300,1) + randn(300,2)*R;

mu = [3 3];
Sigma = [.05 .0; .0 .05];
R = chol(Sigma);
c3 = repmat(mu,300,1) + randn(300,2)*R;

mu = [-2 -0];
Sigma = [.05 .0; .0 .05];
R = chol(Sigma);
c4 = repmat(mu,300,1) + randn(300,2)*R;

mu = [-3 -1];
Sigma = [.05 .0; .0 .05];
R = chol(Sigma);
c5 = repmat(mu,300,1) + randn(300,2)*R;

mu = [-2 -1];
Sigma = [.05 .0; .0 .05];
R = chol(Sigma);
c6 = repmat(mu,300,1) + randn(300,2)*R;

mu = [-2 2];
Sigma = [.05 .0; .0 .05];
R = chol(Sigma);
c7 = repmat(mu,300,1) + randn(300,2)*R;

mu = [-3 3];
Sigma = [.05 .0; .0 .05];
R = chol(Sigma);
c8 = repmat(mu,300,1) + randn(300,2)*R;

mu = [-2 3];
Sigma = [.05 .0; .0 .05];
R = chol(Sigma);
c9 = repmat(mu,300,1) + randn(300,2)*R;

ds = [c1;c2;c3;c4;c5;c6;c7;c8;c9];

end

