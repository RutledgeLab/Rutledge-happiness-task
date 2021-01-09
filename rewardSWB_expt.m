function [data] = rewardSWB_expt(data)

cgmouse;
xcoord = [-150 150];            % location of options

%shuffle trials and itis
gamblemtx   = data.gamblemtx;
gamblemtx   = gamblemtx(randperm(size(gamblemtx,1)),:); %shuffle trials
happytrials = data.happytrials; %0, 50, and every 2-3 between
totalcash   = data.totalcash; %current money

%set timing of experiment
delayperiod   = data.time.delayperiod;  %between choice and outcome
outcomeperiod = data.time.outcomeperiod; %show outcome for this long
ratewait      = data.time.ratewait; %for ratings
switcheveryntrial = data.switcheveryntrial; %switch which side the gamble is on every 10 trials
iti           = data.time.iti;


%trial no, gamble side, certain amount, gamble gain, gamble loss, button
%pressed, gamble chosen, outcome, rt, happy rating, rating start location,
%happy rt, trial start time, actual cgflip trial start time, delay start,
%outcome start, iti start, trial end, happy start, rate start, iti start,
%trial end
ntrial = size(gamblemtx,1);
randgamble = round(rand(ntrial,1));

experiment_data = nan(ntrial+1,23); %the first row is just for rating at the start
experiment_data(:,1) = 0:ntrial;    %trial no
experiment_data(2:end,3:5) = gamblemtx; %certain, gain, loss

gambleside = zeros(ntrial,1);
gambleside(1) = 1+round(rand);      %start with gamble on left (1) or right (2)

allprize = cell(ntrial,3);          %cell array of prizes as strings
for n = 1:ntrial,                   %fill in gambleside info before start
    if n<ntrial,
        if ~mod(n,switcheveryntrial),
            gambleside(n+1) = 3 - gambleside(n); %switch side of the screen gamble is on
        else
            gambleside(n+1) = gambleside(n);
        end;
    end;
    experiment_data(n+1,2) = gambleside(n); %left 1, right 2
    %convert trial prizes to strings
    for p = 1:3, %certain, gain, loss
        if gamblemtx(n,p)==0,
            allprize{n,p} = '£0';
        elseif gamblemtx(n,p)>0,
            allprize{n,p} = sprintf('+£%.2f',gamblemtx(n,p)/100);
        else
            allprize{n,p} = sprintf('-£%.2f',abs(gamblemtx(n,p))/100);
        end;
    end;
end;


%draw blank screen, show welcome screen and wait for button press
cgflip(0,0,0);
wait(1000); %wait 1s

cgpencol(1,1,1);
cgtext('The outcome of every choice you make from now on counts for REAL money.',0,300);
cgtext('If you win more than you lose, you will receive those additional',0,250);
cgtext('earnings. All gambles have a 50% chance of each outcome.',0,200);
cgtext('The computer picks random numbers to determine the outcome of gambles.',0,150);
cgtext('How much you earn depends both on your choices and on how lucky you are.',0,100);
cgtext('Unlike in the practice session, your current earnings will not be shown.',0,50);
cgtext('The computer will keep track of your earnings.',0,0);
cgtext('Press any mouse button to continue.',0,-300);
cgflip(0,0,0);
wait(data.time.instructiontime); %wait twice as long as normal instructions
[~,~,~,mp]=cgmouse; mp=0; while mp==0, [~,~,~,mp]=cgmouse; end;


%run main experiment
tstart = time;                      %get time in ms from first time call
experiment_data(1,13) = 0;          %start time for first trial

for n = 0:ntrial,
    if n > 0, %first trial is just a rating
        cgpencol(1,1,1); cgtext('+', 0, 0); %white fixation cross
        cgrect(xcoord(3-gambleside(n)),0,150,150); %rectangles
        cgrect(xcoord(gambleside(n)),80,150,150);
        cgrect(xcoord(gambleside(n)),-80,150,150);
        cgpencol(0,0,0); cgtext(allprize{n,1},xcoord(3-gambleside(n)),0); %prizes
        cgtext(allprize{n,2},xcoord(gambleside(n)),80);
        cgtext(allprize{n,3},xcoord(gambleside(n)),-80);
        cgflip(0,0,0);
        tstart2 = time; %within trial timer
        experiment_data(n+1,14) = (tstart2 - tstart)/1000; %time since start of this task
        
        [~,~,~,mp]=cgmouse; mp=0; %no mouse press yet
        while (mp ~=1) && (mp ~=4), %1 from leftmouse, 4 for rightmouse
            [~,~,~, mp] = cgmouse;
        end;
        rt = (time - tstart2)/1000; %rt in s
        choicemade = sqrt(mp); %1 for left, 2 for right
        experiment_data(n+1,6) = choicemade; %which button pressed or 0 for none
        experiment_data(n+1,7) = choicemade == gambleside(n); %chose gamble
        experiment_data(n+1,9) = rt;   %rt in s
        if experiment_data(n+1,7), %chose gamble
            cgpencol(1,1,1); cgtext('+', 0, 0); %display gamble chosen
            cgrect(xcoord(gambleside(n)),80,150,150);
            cgrect(xcoord(gambleside(n)),-80,150,150);
            cgpencol(0,0,0);
            cgtext(allprize{n,2},xcoord(gambleside(n)),80);
            cgtext(allprize{n,3},xcoord(gambleside(n)),-80);
            cgflip(0,0,0);
            experiment_data(n+1,15) = (time - tstart)/1000; %delay onset - time since start of this task
            if randgamble(n) == 1, %better gamble outcome in exactly half the trials
                experiment_data(n+1,8) = gamblemtx(n,2); %outcome received
                cgpencol(1,1,1); cgtext('+', 0, 0); cgrect(xcoord(gambleside(n)),80,150,150);
                cgpencol(0,0,0); cgtext(allprize{n,2},xcoord(gambleside(n)),80);
            else %worse gamble outcome
                experiment_data(n+1,8) = gamblemtx(n,3);
                cgpencol(1,1,1); cgtext('+', 0, 0); cgrect(xcoord(gambleside(n)),-80,150,150);
                cgpencol(0,0,0); cgtext(allprize{n,3},xcoord(gambleside(n)),-80);
            end;
            while ((time-tstart)/1000 - experiment_data(n+1,15)) < delayperiod/1000, end; %wait delay period
            cgflip(0,0,0);
            experiment_data(n+1,16) = (time - tstart)/1000; %outcome onset - time since start of this task
            while ((time-tstart)/1000 - experiment_data(n+1,16)) < outcomeperiod/1000, end; %wait outcome period
        else %chose certain amount
            experiment_data(n+1,8) = gamblemtx(n,1);
            cgpencol(1,1,1); cgtext('+', 0, 0); cgrect(xcoord(3-gambleside(n)),0,150,150);
            cgpencol(0,0,0); cgtext(allprize{n,1},xcoord(3-gambleside(n)),0);
            cgflip(0,0,0);
            experiment_data(n+1,15:16) = (time - tstart)/1000; %outcome onset - time since start of this task
            while ((time-tstart)/1000 - experiment_data(n+1,15)) < (outcomeperiod)/1000, end; %wait outcome period only
        end;
        %start iti
        cgpencol(1,1,1); cgtext('+', 0, 0);
        cgflip(0,0,0); %clear it
        experiment_data(n+1,17) = (time - tstart)/1000; %iti onset
        experiment_data(n+1,18) = experiment_data(n+1,17) + iti/1000;
        if n<ntrial,
            experiment_data(n+2,13) = experiment_data(n+1,18); %start time of next trial is end time of previous
        end;
        trialoutcomes = experiment_data(~isnan(experiment_data(:,8)),8);
        data.totalcash = totalcash + sum(trialoutcomes)/100;
        data.behavedata = experiment_data;
        while (time-tstart)/1000 < experiment_data(n+1,18), end; %wait until end of iti
    else
        experiment_data(1,18) = 0;
    end;
    
    %run happy rating if necessary
    if sum(n == happytrials), %ask on predetermined trials
        [experiment_data(n+1,10), experiment_data(n+1,11), experiment_data(n+1,12), alltime] = happy_rating('happy',ratewait); %respkeys, waittime, resptime, startlocation, pixperkey);
        cgpencol(1,1,1); cgtext('+', 0, 0); cgflip(0,0,0);
        experiment_data(n+1,19) = (alltime(1) - tstart)/1000; %happy question onset
        experiment_data(n+1,20) = (alltime(2) - tstart)/1000; %happy line onset
        experiment_data(n+1,21) = experiment_data(n+1,20) + experiment_data(n+1,12); %happy rating made
        experiment_data(n+1,22) = (time - tstart)/1000;       %ITI (0.7s) and 1s of looking at rating already built in
        if n<ntrial,
            experiment_data(n+2,13) = experiment_data(n+1,22);
        end;
        data.behavedata = experiment_data;
        %save data after every happy rating
        eval(sprintf('save %s data',fullfile(data.dir,data.filename))); %save data
    end;
end;