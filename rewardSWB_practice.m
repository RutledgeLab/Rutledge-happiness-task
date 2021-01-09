function [practice_data] = rewardSWB_practice(data)

practicemtx       = data.practicemtx;
delayperiod       = data.time.delayperiod;
outcomeperiod     = data.time.outcomeperiod;
switcheveryntrial = data.switcheveryntrial;
iti               = data.time.iti;
currentmoney      = data.endowment * 100;





cgmouse;
%----------------------------------
ntrial = size(practicemtx,1);
randgamble = round(rand(ntrial,1));

%trial no, trialstarttime, gamble side, certain amount, gamble gain, gamble loss, gamble chosen, outcome, rt, happy rating, random starting rating, happy rt
practice_data = nan(ntrial,12);
practice_data(:,1) = 1:ntrial;    %trial no
practice_data(:,4:6) = practicemtx; %certain, gain, loss

gambleside = zeros(ntrial,1);
gambleside(1) = 1+round(rand);      %start with gamble on left (1) or right (2)
tstart = time;                      %get time in ms from first time call
xcoord = [-150 150];
allprize = cell(ntrial,3);          %cell array of prizes as strings
for n = 1:ntrial,                   %fill in gambleside info before start
    if n<ntrial,
        if ~mod(n,switcheveryntrial),
            gambleside(n+1) = 3 - gambleside(n); %switch side of the screen gamble is on
        else
            gambleside(n+1) = gambleside(n);
        end;
    end;
    practice_data(n,3) = gambleside(n); %left 1, right 2
    %convert trial prizes to strings
    for p = 1:3, %certain, gain, loss
        if practicemtx(n,p)==0,
            allprize{n,p} = '£0';
        elseif practicemtx(n,p)>0,
            allprize{n,p} = sprintf('+£%.2f',practicemtx(n,p)/100);
        else
            allprize{n,p} = sprintf('-£%.2f',abs(practicemtx(n,p))/100);
        end;
    end;
end;

%draw blank screen, show welcome screen and wait for button press
cgflip(0,0,0);
wait(1000); %wait 5s

%run practice session
for n = 1:ntrial,
    practice_data(n,2) = (time - tstart)/1000; %time since start of this task
    %draw gambles
    cgpencol(1,1,1); cgtext('+', 0, 0); %white fixation cross
    cgtext('Practice session - not for real money.',0,-250);
    if currentmoney >= 0,
        cgtext(sprintf('If it counted for real money, you would have £%.2f.',currentmoney/100),0,-300);
    else
        cgtext(sprintf('If it counted for real money, you would have -£%.2f.',abs(currentmoney/100)),0,-300);
    end;
    cgrect(xcoord(3-gambleside(n)),0,150,150); %rectangles
    cgrect(xcoord(gambleside(n)),80,150,150);
    cgrect(xcoord(gambleside(n)),-80,150,150);
    cgpencol(0,0,0); cgtext(allprize{n,1},xcoord(3-gambleside(n)),0); %prizes
    cgtext(allprize{n,2},xcoord(gambleside(n)),80);
    cgtext(allprize{n,3},xcoord(gambleside(n)),-80);
    cgflip(0,0,0);
    tstart2 = time; %within trial timer
    
    [~,~,~,mp]=cgmouse; mp=0; %no mouse press yet
    while (mp ~=1) && (mp ~=4), %1 from leftmouse, 4 for rightmouse
        [~,~,~,mp] = cgmouse;
    end;
    practice_data(n,7) = sqrt(mp)==gambleside(n); %chose gamble
    practice_data(n,9) = (time - tstart2)/1000; %rt in s
    
    if practice_data(n,7), %if chose gamble
        cgpencol(1,1,1); cgtext('+', 0, 0); %display gamble chosen
        cgtext('Practice session - not for real money.',0,-250);
        if currentmoney >= 0,
            cgtext(sprintf('If it counted for real money, you would have £%.2f.',currentmoney/100),0,-300);
        else
            cgtext(sprintf('If it counted for real money, you would have -£%.2f.',abs(currentmoney/100)),0,-300);
        end;
        cgrect(xcoord(gambleside(n)),80,150,150);
        cgrect(xcoord(gambleside(n)),-80,150,150);
        cgpencol(0,0,0);
        cgtext(allprize{n,2},xcoord(gambleside(n)),80);
        cgtext(allprize{n,3},xcoord(gambleside(n)),-80);
        cgflip(0,0,0); wait(delayperiod);
        
        if randgamble(n)==1, %better gamble outcome in half the trials
            practice_data(n,8) = practicemtx(n,2);
            cgpencol(1,1,1); cgtext('+', 0, 0); cgrect(xcoord(gambleside(n)),80,150,150);
            cgpencol(0,0,0); cgtext(allprize{n,2},xcoord(gambleside(n)),80);
            currentmoney = currentmoney + practicemtx(n,2);
        else %worse gamble outcome
            practice_data(n,8) = practicemtx(n,3);
            cgpencol(1,1,1); cgtext('+', 0, 0); cgrect(xcoord(gambleside(n)),-80,150,150);
            cgpencol(0,0,0); cgtext(allprize{n,3},xcoord(gambleside(n)),-80);
            currentmoney = currentmoney + practicemtx(n,3);
        end;
        cgpencol(1,1,1); cgtext('Practice session - not for real money.',0,-250);
        if currentmoney >= 0,
            cgtext(sprintf('If it counted for real money, you would have £%.2f.',currentmoney/100),0,-300);
        else
            cgtext(sprintf('If it counted for real money, you would have -£%.2f.',abs(currentmoney/100)),0,-300);
        end;
        cgflip(0,0,0); wait(outcomeperiod); %display gamble outcome
    else %chose certain amount
        practice_data(n,8) = practicemtx(n,1);
        currentmoney = currentmoney + practicemtx(n,1);
        cgpencol(1,1,1); cgtext('+', 0, 0); cgrect(xcoord(3-gambleside(n)),0,150,150);
        cgtext('Practice session - not for real money.',0,-250);
        if currentmoney >= 0,
            cgtext(sprintf('If it counted for real money, you would have £%.2f.',currentmoney/100),0,-300);
        else
            cgtext(sprintf('If it counted for real money, you would have -£%.2f.',abs(currentmoney/100)),0,-300);
        end;
        cgpencol(0,0,0); cgtext(allprize{n,1},xcoord(3-gambleside(n)),0);
        cgflip(0,0,0); wait(delayperiod+outcomeperiod);
    end;
    
    %start iti
    cgpencol(1,1,1); cgtext('+', 0, 0);
    cgtext('Practice session - not for real money.',0,-250);
    if currentmoney >= 0,
        cgtext(sprintf('If it counted for real money, you would have £%.2f.',currentmoney/100),0,-300);
    else
        cgtext(sprintf('If it counted for real money, you would have -£%.2f.',abs(currentmoney/100)),0,-300);
    end;
    cgflip(0,0,0); %clear it
    wait(iti);     %3s+rt per trial
end;

cgpencol(1,1,1);
cgtext('You have completed the practice session.',0,300);
cgtext('Press any mouse button to continue.',0,-300);
cgflip(0,0,0);
[~,~,~,mp]=cgmouse; mp=0; while mp == 0, [~,~,~,mp] = cgmouse; end;


