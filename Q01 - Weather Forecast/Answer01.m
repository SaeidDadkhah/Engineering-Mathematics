%% Init
clear

generalMarkov = @(state, transition, n) (state * transition^n);
forecast = @(n, first_day) ...
    (generalMarkov(first_day, ...
    [.4, .4, .2;...
    .3, .3, .4;...
    .1, .6, .3], ...
    n));

%% Part A
%{
Today weather condition: twc
Weather forcast of n'th day: wf
%}
n = 1;
twc = [0 1 0];
wf = forecast(n, twc);
display(wf)

input('Press any key to continue...');

%% Part B
%{
To answer this question we should only assign a large enought number to n.
For any valid intial state and large (enough) n this will result in weather
forcast of any day without considering weather forecast of it's previous
day.
%}
n = 500;
generalWF = forecast(n, twc);
display(generalWF)

input('Press any key to continue...');

%% Part C
%{
Change n, init, and trans to check the function.
%}
n = 2;
init = [1 0];
trans = ...
    [.2, .8; ...
    .7, .3];
res = generalMarkov(init, trans, n);
display(res)
