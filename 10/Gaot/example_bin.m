format compact

% Setting the seed to the same for binary
% rand('seed',156789)

global bounds

% Bounds on the variables
bounds = [-3 12.1; 4.1 5.8];

% Generate an intialize population of size 20 for binary version
startPop = initializega(20,bounds,'michal',[],[1e-6 0]);

% Generate an intialize population of size 20
% startPop = initializega(20,bounds,'michal',[1e-6 1])

% Binary Crossover Operators
xFns = 'simpleXover';
xOpts = [0.8];

% Crossover Operators
% xFns = 'arithXover heuristicXover simpleXover';
% xOpts = [1 0; 1 3; 1 0];

% Binary Mutation Operators
mFns = 'binaryMutation';
mOpts = [0.005];

% Mutation Operators
% mFns = 'boundaryMutation multiNonUnifMutation nonUnifMutation unifMutation';
% mOpts = [2 0 0;3 200 3;2 200 3;2 0 0];

% Termination Operators
termFns = 'maxGenTerm';
termOps = [200]; % 200 Generations

% Selection Function 
selectFn = 'roulette';
selectOps = [];

% selectFn = 'tournSelect';
% selectOps = [2];

% selectFn = 'normGeomSelect';
% selectOps = [0.08];

% Evaluation Function
evalFn = 'michal';
evalOps = [];

% GA Options [epsilon float/binar display]
gaOpts=[1e-6 0 1];

% Lets run the GA
[x endPop bestPop trace]=ga(bounds,evalFn,evalOps,startPop,gaOpts,...
    termFns,termOps,selectFn,selectOps,xFns,xOpts,mFns,mOpts);


% x is the best solution found
disp('Best solution') 
x
disp('Hit a return to continue')
pause


% endPop is the ending population
disp('Ending population')
endPop
disp('Hit a return to continue')
pause


% bestPop is the best solution tracked over generations
disp('Best solution tracked over generations')
bestPop
disp('Hit a return to continue')
pause


% trace is a trace of the best value and average value of generations
% trace
% Hit a return to continue
% pause


% Plot the best over time
clf
plot(trace(:,1),trace(:,2));
% Add the average to the graph
hold on
plot(trace(:,1),trace(:,3));
hold off
