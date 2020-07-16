function  Fb = generate_random_step_inputs(time,steps)
    % prepare random step inputs


    flow_rate = ones(length(time),1);


    remainder = rem(length(time), steps);

    idx = 1:(length(time) - remainder)/steps:(length(time)-remainder);

    for i = 1:steps
        flow_rate(idx(i):(idx(i) + (length(time) - remainder)/steps - 1) ) = (100-0) * rand();

    end

    if remainder ~= 0
        flow_rate((length(time) - remainder + 1) : length(time)) = (100-0) * rand();
    end

    length(flow_rate)
    Fb = timetable(seconds(time)', flow_rate);


end

