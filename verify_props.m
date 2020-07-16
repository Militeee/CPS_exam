function [qMonitorResult1, qMonitorResult2] = verify_props(simu, robMin,upper,lower,delay,fin_time)
%   Just evaluates the two properties given an input

signal = simu.pH;

time = simu.tout;
moonlightScript = ScriptLoader.loadFromFile("specs");


moonlightScript.setMinMaxDomain();

qMonitor = moonlightScript.getMonitor("Upper");
qMonitorResult1  = qMonitor.monitor(time, signal, [upper, delay, fin_time]);
    if qMonitorResult1(1,2) < robMin
        fprintf('The property is falsified \n');
    else 
        fprintf('minRob = %f \n', robMin);
    end
 
qMonitor = moonlightScript.getMonitor("Lower");
qMonitorResult2  = qMonitor.monitor(time, signal, [lower, delay, fin_time]);
    if qMonitorResult2(1,2) < robMin
        fprintf('The property is falsified \n');
    else 
        fprintf('minRob = %f \n', robMin);
    end
    
end

