clear();
mu1 = [2 2];
sigma1 = [1 0; 0 1];

x1 = -10:0.1:10;
x2 = -10:0.1:10;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];
y1 = mvnpdf(X,mu1,sigma1);
y=y1+0.003*randn(size(y1));
y=reshape(y,length(x1),length(x2));


hold on
surf(x1,x2,y);                           % Fitted Surface
hold off
xlabel('X \rightarrow')
ylabel('\rightarrow Y')
zlabel('Z \rightarrow')
grid

% Create input independent variable (10 x 10 x 2):
XY(:,:,1) = X1;
XY(:,:,2) = X2;
% Create Objective Function: 
surfit=@(B,XY) 1/(2  .*3.14.* B(1) .* B(2)) .* exp( - ((X1-B(3)).^2)./2 .* B(1).^2 - ((X2-B(4)).^2)./2 .* B(2).^2);
 

% Do Regression
B0=[1.2 1.2 1.8 1.8];
B = lsqcurvefit(surfit, B0, XY, y);
% Calculate Fitted Surface:
Z = surfit(B,XY); 
% Plot: 
figure(2)
             % Original Data
hold on
surf(X1, X2, Z)                           % Fitted Surface
hold off
xlabel('X \rightarrow')
ylabel('\rightarrow Y')
zlabel('Z \rightarrow')
grid