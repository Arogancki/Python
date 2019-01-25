format compact

% Setting the seed to the same for binary
% rand('seed',156789)

%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
functionName = 'DeJongF2';
metoda_selekcji = 'tournSelect'; %'tournSelect' 'roulette'
parametry_krzyzowania = [2 0; 3 3; 3 0];
parametry_mutacji = [1 0 0;2 100 1;2 100 1;1 0 0];
gdzie = [13 100; 0 100];
max = 200;

%figure(1)
[xx,yy]=meshgrid(gdzie);
%rys2D(functionName,xx,yy);
%pause

global bounds

%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% Bounds on the variables
%bounds to sa gdzie
bounds = gdzie;

% Generate an intialize population of size 20
startPop = initializega(20,bounds,functionName,[],[1e-6 1]);

% Binary Crossover Operators
% xFns = 'simpleXover';
% xOpts = [0.8];

%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% Crossover Operators
xFns = 'arithXover heuristicXover simpleXover';
xOpts = parametry_krzyzowania;

% Binary Mutation Operators
% mFns = 'binaryMutation';
% mOpts = [0.05];

%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% Mutation Operators
mFns = 'boundaryMutation multiNonUnifMutation nonUnifMutation unifMutation';
mOpts = parametry_mutacji;

%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% Termination Operators
termFns = 'maxGenTerm';
termOps = [max]; % 200 Generations

%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% Selection Function 
% selectFn = 'roulette';
% selectOps = [];

selectFn = metoda_selekcji;
selectOps = [2];

% Selection Function
% selectFn = 'normGeomSelect';
% selectOps = [0.08];

% Evaluation Function
evalFn = functionName;
evalOps = [];

% GA Options [epsilon float/binar display]
gaOpts=[1e-6 1 1];

% Lets run the GA
[x endPop bestPop trace]=ga(bounds,evalFn,evalOps,startPop,gaOpts,...
    termFns,termOps,selectFn,selectOps,xFns,xOpts,mFns,mOpts);

% x is the best solution found
x
war = DeJongF2(x);
war
% endPop is the ending population
%endPop
% bestPop is the best solution tracked over generations
%bestPop

% Plot the best over time
figure(2)
plot(trace(:,1),trace(:,2));
% Add the average to the graph
hold on
plot(trace(:,1),trace(:,3));
hold off
