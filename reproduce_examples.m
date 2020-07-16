clc;
clear all;

rng(0,'twister');


% define the parameters

model_PID = 'plant_PID_simple';
model_neural = 'plant_neural';
model_fuzzy = 'plant_fuzzy';
dt = 0.05;
fin_time = 200;
time = (1:dt:fin_time)';

% define the global variables 

Ca = 0.005; % mol/L
Cb = 0.005; % mol/L
fA = 2; % mL/s
fB = 2; % mL/s
V = 3; %L
reference = 7; %pH
time_ref = 10000;

Ki = 0.8;
Kp = 0.3;
Kd = 0.01;

%test 1 close-open

use_step = 1;
out_valv = [50]';
time_valv = 100000;  % sec




simOutPID = sim(model_PID, 'StopTime', num2str(fin_time));

simOutNeural = sim(model_neural, 'StopTime', num2str(fin_time));

simOutFuzzy = sim(model_fuzzy, 'StopTime', num2str(fin_time));


plot_res(simOutPID,simOutNeural,simOutFuzzy, time, 7,5.5,8.5);

verify_props(simOutPID, 2, 8.5, 5.5 , 50, fin_time);
verify_props(simOutNeural, 2, 8.5, 5.5 , 50, fin_time);
verify_props(simOutFuzzy, 2, 10, 5.5 , 50, fin_time);

% test 2 close-open w/t perturbation


out_valv = [50,50,50,50,50,50,50,50,50,50,10]';

time_valv = 10;  % sec


simOutPID = sim(model_PID,  'StopTime', num2str(fin_time));

simOutNeural = sim(model_neural,  'StopTime', num2str(fin_time));

simOutFuzzy = sim(model_fuzzy, 'StopTime', num2str(fin_time));

plot_res(simOutPID,simOutNeural,simOutFuzzy, time, 7,5,9);


verify_props(simOutPID, 0, 10, 4 , 50, fin_time);
verify_props(simOutNeural, 0, 10, 4 , 50, fin_time);
verify_props(simOutFuzzy, 0, 10, 4 , 50, fin_time);


% test 3 servo change

out_valv = [50]';
time_valv = 10000;  % sec


reference = [7,6.5,7.5]';
time_ref = 70; % sec


simOutPID = sim(model_PID, 'StopTime', num2str(fin_time));

simOutNeural = sim(model_neural, 'StopTime', num2str(fin_time));

simOutFuzzy = sim(model_fuzzy, 'StopTime', num2str(fin_time));



plot_res(simOutPID,simOutNeural,simOutFuzzy, time, 7,5,9);

verify_props(simOutPID, 0, 9, 7 , 0, 70);
verify_props(simOutPID, 0, 8.5, 4.5 , 70, 140);
verify_props(simOutPID, 0, 9.5, 5.5 , 140, fin_time);

% check minumum valve perturbation for the property to hold

run_search = 0;


if run_search ~0
    valve_pert = [10,40,45,48,49,49.5, 49.8]
    for i= valve_pert
        out_valv = [50,50,50,50,50,50,50,50,50,50,i]';
        time_valv = 10;
        simOutPID = sim(model_PID, 'StopTime', num2str(fin_time));
        prop = verify_props(simOutPID, 0, 10, 4 , 50, fin_time);
        if prop(1,2) > 0
           fprintf("Model verified for change %f \n", i); 
           break
        end
    end
    
    
end


