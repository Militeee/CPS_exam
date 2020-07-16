function plot_res(pid,neural,fuzzy, time,ref,lower,upper)
    
% plot results of a test together

    y_ref = ones(numel(time)) * ref;
    y_lower = ones(numel(time)) * lower;
    y_upper = ones(numel(time)) * upper;
    
    figure
    plot(pid.tout,pid.pH,'r--');
    hold on;
    plot(neural.tout,neural.pH,'g--');
    hold on;
    plot(fuzzy.tout,fuzzy.pH,'b--');
    hold on;
    plot(time,y_ref,'-', 'LineWidth',1);
    hold on;
    plot(time,y_lower,'r:', 'LineWidth',1);
    hold on;
    plot(time,y_upper,'r:', 'LineWidth',1);
    hold on;
    legend('PID','Neural Controller', 'Fuzzy','Reference');
    ylim([0,14]);

end