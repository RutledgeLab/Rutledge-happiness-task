function [rating, randstart, rt, alltime] = happy_rating(ratingtype, waittime)

%[rating, randstart, rt] = happy_rating(ratingtype)
%if ratingtype unused, asks how happy you are at the moment with no wait
%if ratingtype is 'lifehappy', asks how happy you are +wait
%if ratingtype is 'nowhappy', asks how happy you are +wait
%if ratingtype is 'happy', ask how happy you are +wait
%before your first trial for money +wait
%waits for WAITTIME milliseconds until asking for rating

timelimit = Inf;

%--------------------------------------------------
sx = [-384 384]; sy = [0 0]; %in pixels, since it's 1024 wide, this is 75% of the screen

%random start with the mouse means occasionally they will have to pick up
%the mouse if they consistently rate above or below the midpoint because on
%average the mouse will end up in the center of the line between trials.

%randstart = rand;             %start in a random location on the line (0,1)
randstart = 0.5;               %skip the randstart and just start from the middle
rating = nan; rt = nan;        %in case early exit


cgpencol(1,1,1);
if exist('ratingtype'),
    if strcmp(ratingtype,'lifehappy'),
        cgtext('Taken all together, how happy are you with your life these days?',0,300);
        cgtext('Mark your rating relative to the least and most happy time of your life.',0,250);
    elseif strcmp(ratingtype,'nowhappy'),
        cgtext('Think about right now. How happy are you at this moment?',0,300);
    elseif strcmp(ratingtype,'happy'),
        cgtext('How happy are you at this moment?',0,300);
    end;
    cgflip(0,0,0); 
    tstart = time;                %get time in ms from first time call
    wait(waittime);
    tstart2 = time;
    alltime = [tstart tstart2];
else
    cgtext('How happy are you at this moment?',0,300);
    cgflip(0,0,0);
    tstart2 = time;               %get time in ms from first time call
    alltime = [tstart2 tstart2];
end;


mp = 0; x = 0; y = 0; %initialize mouse to center of screen at moment line appears
cgmouse((sx(2)-sx(1))*randstart + sx(1), 0); %mouse jumps to random location on line
while (mp < 1) && time < tstart + timelimit;
    cgpencol(1,1,1);
    if exist('ratingtype'),
        if strcmp(ratingtype,'lifehappy'),
            cgtext('Taken all together, how happy are you with your life these days?',0,300);
            cgtext('Mark your rating relative to the least and most happy time of your life.',0,250);
        elseif strcmp(ratingtype,'nowhappy');
            cgtext('Think about right now. How happy are you at this moment?',0,300);
        elseif strcmp(ratingtype,'happy'),
            cgtext('How happy are you at this moment?',0,300);
        end;
        if sum(strfind(ratingtype,'happy')), %not money
            cgtext('very',sx(1)-38,sy(1)+10); cgtext('unhappy',sx(1)-65,sy(1)-20);
            cgtext('very',sx(2)+37,sy(2)+10); cgtext('happy',sx(2)+50,sy(2)-20);
        end;
    else
        cgtext('How happy are you at this moment?',0,300);
    end;
    
    cgpencol(0.5,0.5,0.5); cgdraw(sx(1),sy(1),sx(2),sy(2)); %draw rating line
    cgpencol(1,1,1); cgellipse(sx(1),sy(1),10,10,'f');
    cgellipse(sx(2),sy(2),10,10,'f');
    
    % update mouse position
    [x, ~, ~, mp] = cgmouse; y = 0;
    if x < sx(1), x = sx(1); end
    if x > sx(2), x = sx(2); end;
    cgpencol(1,1,0); cgellipse(x,y,10,10,'f');
    cgflip(0,0,0);
end
rating = (x - sx(1)) / (sx(2) - sx(1)); %0 to 1
rt = (time - tstart2)/1000; %in s since end of waittime

%%%%%%%%%%%%%
wait(1000); %show rating made for 1s
cgpencol(1,1,1); cgtext('+', 0, 0);
cgflip(0,0,0);
wait(700); %show fixation cross for 700ms
