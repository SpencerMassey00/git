clear 
clc

sample = readtable('breathing.csv');
t7 = sample{:,1}.';
y7 = sample{:,2}.';


% analyzeRESP calculates respiration rate using time and frequency domain
% analyses

time = t7;
resp = y7;
plotsOn = false;
thirty = false;
compare = true;
    % INPUTS: 
    % time: elapsed time (seconds)
    % resp: output from pressure sensor (voltage)
    % plotsOn: true for plots, false for no plots
    
    % OUTPUT:
    % rr: respiration rate (brpm) found from time domain data
    % rr_fft: respiration rate (brpm) found from frequency domain data

    % save orgiinal data
    time_raw = time;
    resp_raw = resp;

    % calculate fs
    fs = length(time) / max(time);

    % remove offset
    resp = resp - mean(resp);

    % bandpass pass filter resp
    w1 = .2; % FILL IN CODE HERE
    w2 = .4175; % FILL IN CODE HERE
    resp = bandpass(resp,[w1 w2],fs);

    % find peaks
    pks = findpeaks(resp, fs); % FILL IN CODE HERE (look at findpeaks documentation)

    % calcuate rr
    rr = numel(pks) ./ (max(time) / 60); % FILL IN CODE HERE

    % fft
    Y = fft(resp);
    T = 1/fs;
    L = length(time);
    t = (0:L-1)*T;
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1) % FILL IN CODE HERE (look at fft documentation
    f = fs*(0:(L/2))/L; % FILL IN CODE HERE (look at fft documentation)
    % calcuate rrFft
    x = 0;
    [x, y] = max(P1);
    rr_fft = 60 * f(y); % FILL IN CODE HERE (hint: look at max documentation)

    if plotsOn
        figure % FILL IN CODE HERE to add legends, axes labels, and * for peaks
        subplot(3,1,1) 
        plot(time_raw,resp_raw)
        title('Provided Sample')
        xlabel('Elapsed Time (s)')
        ylabel('Voltage (V)')
        
        TF = islocalmax(resp);
        
        subplot(3,1,2)
        plot(time,resp,time(TF),resp(TF), 'r*')
        xlabel('Elapsed Time (s)')
        ylabel('Filtered Voltage')
        legend('RESP', "Grace RR (brpm): " + rr)
        
        [P1_max, index] = max(P1);
        f_max = f(index);
        
        subplot(3,1,3)
        plot(f,P1,f_max,P1_max,'r*')
        xlabel('Frequency (Hz)')
        ylabel('|P1(f)|')
        legend('RESP', "Grace RR FFT (brpm): " + rr_fft)
        
    end
    
    if thirty
        range1 = find(time > 120);
        range2 = find(time > 150);
        resp = resp(range1(1):range2(1));
        time = time(range1(1):range2(1));
        
        % calculate fs
        fs = length(time) / max(time);
        
        % remove offset
        resp = resp - mean(resp);
        
        % bandpass pass filter resp
        w1 = 0.05; % FILL IN CODE HERE
        w2 = 0.4; % FILL IN CODE HERE
        resp = bandpass(resp,[w1 w2],fs);
        
        % find peaks
        pks = findpeaks(resp, fs); % FILL IN CODE HERE (look at findpeaks documentation)
        
        % calcuate rr
        rr = numel(pks) ./ ((max(time) - time(1)) / 60); % FILL IN CODE HERE
        
        Y = fft(resp)
        T = 1/fs;
        L = length(time);
        t = (0:L-1)*T;
        P2 = abs(Y/L);
        P1 = P2(1:L/2+1) % FILL IN CODE HERE (look at fft documentation
        f = fs*(0:(L/2))/L; % FILL IN CODE HERE (look at fft documentation)
        % calcuate rrFft
        x = 0;
        [x, y] = max(P1);
        rr_fft = 60 * f(y); % FILL IN CODE HERE (hint: look at max documentation)
        
        figure 
        subplot(3,1,1) 
        plot(time_raw(range1(1):range2(1)),resp_raw(range1(1):range2(1)))
        title('Provided Sample')
        xlabel('Elapsed Time (s)')
        ylabel('Voltage (V)')
        
        TF = islocalmax(resp);
        
        subplot(3,1,2)
        plot(time,resp,time(TF),resp(TF), 'r*')
        xlabel('Elapsed Time (s)')
        ylabel('Filtered Voltage')
        legend('RESP', "Grace RR (brpm): " + rr)
        
        [P1_max, index] = max(P1);
        f_max = f(index);
        
        subplot(3,1,3)
        plot(f,P1,f_max,P1_max,'r*')
        xlabel('Frequency (Hz)')
        ylabel('|P1(f)|')
        legend('RESP', "Grace RR FFT (brpm): " + rr_fft)
        
    end
    
    if compare
        
        x = 0;
        n = 0;
        while n < 8
            range1 = find(time > x);
            range2 = find(time > (x + 30));
            resp = resp(range1(1):range2(1));
            time = time(range1(1):range2(1));
            % calculate fs
   fs = length(time) / max(time);
        
        % remove offset
        resp = resp - mean(resp);
        
        % bandpass pass filter resp
        w1 = 0.05; % FILL IN CODE HERE
        w2 = 0.4; % FILL IN CODE HERE
        resp = bandpass(resp,[w1 w2],fs);
        
        % find peaks
        pks = findpeaks(resp, fs); % FILL IN CODE HERE (look at findpeaks documentation)
        
        % calcuate rr
        rr(n+1) = numel(pks) ./ ((max(time) - time(1)) / 60); % FILL IN CODE HERE
        
        Y = fft(resp);
        T = 1/fs;
        L = length(time);
        t = (0:L-1)*T;
        P2 = abs(Y/L);
        P1 = P2(1:L/2+1) % FILL IN CODE HERE (look at fft documentation
        f = fs*(0:(L/2))/L; % FILL IN CODE HERE (look at fft documentation)
        % calcuate rrFft
        z = 0;
        [z, y] = max(P1);
        rr_fft(n+1) = 60 * f(y); % FILL IN CODE HERE (hint: look at max documentation)
        x = x + 30;
        n = n + 1;
        end
        
        figure() 
        plot(time, rr, rr_fft)
        title('Provided sample')
        xlabel('Elapsed Time (s)')
        ylabel('RR (brpm)')
        legend('Grace rr', 'Grace rr fft')
        
    end
    
    
    