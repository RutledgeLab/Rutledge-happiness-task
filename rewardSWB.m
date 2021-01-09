function rewardSWB(subjectid)

% rewardSWB(SUBJECTID)
%
% example:
%    rewardSWB('fr001')
%
% Experiment includes 150 trials and 61 happiness ratings and takes around
% 30min to run. It starts with instructions and a brief practice session.
%
% if things are not going well, this is how to force it to quit:
% 1) hold down alt and press tab repeatedly to get to matlab. once
%    in matlab, ctl-c to shop the program. close and reopen matlab.
% 2) ctl-alt-del to go to task manager. select matlab and then click end
%    task to force matlab to quit. restart matlab.
%
% Robb Rutledge, November 2014


addpath(genpath('D:\Cogent2000v1.30'));

%% GENERAL STARTUP
rand('seed',sum(100*clock));
data           = struct;
data.id        = lower(subjectid);
data.endowment = 20; %£10 endowment
data.totalcash = 20; %will be total at end
data.date      = datestr(date,'yyyy-mm-dd');
data.starttime = datestr(now,'HH:MM:SS');
data.dir       = [data.id '_' data.date];
data.filename  = sprintf('%s_rewardSWB_%s_%s_%s',data.id,data.date,data.starttime(1:2),data.starttime(4:5));


%make local data directory
if ~exist(data.dir),
    mkdir(data.dir);
end;
if ~isempty(dir(fullfile(data.dir,'*_rewardSWB_*.mat'))), %check if existing data file
    fprintf(1,'Date file for this task for %s already exists.\n',data.id);
    overwrite = input('Continue and make a new data file (yes/no)? ','s');
    if length(overwrite) && strmatch(overwrite,'yes'), %cant just press enter has to be y or yes
    else
        return;
    end;
end;


%% Cogent configuration
screenMode = 0;                 % 0 for small window, 1 for full screen, 2 for second screen if attached
screenRes  = 3;                 % 1=640x480; 2=800x600; 3=1024x768
foreground = [1 1 1];           % foreground colour 111 is white
background = [0 0 0];           % background colour
fontName   = 'Arial';           % font parameters
fontSize   = 32;
nbits      = 0;                 % 0 selects the maximum possible bits per pixel

config_display(screenMode, screenRes, background, foreground, fontName, fontSize, 5, nbits);   % open graphics window
config_keyboard;
start_cogent;


%generate set of 150 options and take 50 for the practice to which 10 are
%added that have a correct answer and can be used to check if subjects are
%paying attention - follows design of Sokol-Hessner et al. (2009)
gain         = [30 50 80 110 150];
lossfraction = [0.2 0.3 0.4 0.52   0.66 0.82   1 1.2 1.5 2];
allgain      = repmat(gain,[1 length(lossfraction)]); allgain = allgain(:);
lossmult     = repmat(lossfraction,[length(gain) 1]); lossmult = lossmult(:);
allloss      = round(allgain.*lossmult);
temp         = [zeros(size(allgain)) allgain -allloss];

certain      = [20 30 40 50 60];
gainfraction = [0.84 0.91 1 1.11 1.24     1.4 1.58 1.8 2.1 2.5];
allcertain   = repmat(certain,[1 length(gainfraction)]); allcertain = allcertain(:);
gainmult     = repmat(gainfraction,[length(certain) 1]); gainmult = gainmult(:);
allgain      = round(allcertain.*gainmult*2);
temp         = [temp; [allcertain allgain zeros(size(allcertain))]];
temp         = [temp; [-allcertain zeros(size(allcertain)) -allgain]];
data.gamblemtx = temp;

practicelist = [1 3 7 10 12 13 17 19 24 25 26 28 33 34 36 39 42 45 46 50];
templist     = [52 57 59 61 62 68 73 75 80 84 86 90 91 94 98];
practicelist = [practicelist templist templist+50];
data.practicemtx = [temp(practicelist,:); ...
    [20 20 0; 30 30 0; 40 40 0; 50 50 0; 60 60 0; ...
    -20 0 -20; -30 0 -30; -40 0 -40; -50 0 -50; -60 0 -60]];

%shuffle trials for practice and experiment
data.practicemtx = data.practicemtx(randperm(size(data.practicemtx,1)),:);
data.gamblemtx   = data.gamblemtx(randperm(size(data.gamblemtx,1)),:);

%do 61 ratings in 150 trials
happytrials      = [3*ones(1,30) 2*ones(1,30)];
happytrials      = happytrials(randperm(length(happytrials)));
data.happytrials = [0 cumsum(happytrials)]; %trial 0 and trial 150 the last trial has a rating

data.time.instructiontime = 3000;
data.time.delayperiod     = 4000;
data.time.outcomeperiod   = 1000;
data.time.iti             = 1000;
data.time.ratewait        = 0;  %before can make rating - no time limit
data.switcheveryntrial    = 10; %switch gamble side
%subjects have Inf time to make choices and ratings


%% Run the experiment - £20 endowment
%life happiness
cgpencol(1,1,1);
cgtext('Welcome to the Reward and Subjective Wellbeing task.',0,300);
cgtext('When you are asked to make a rating, use the mouse to move the cursor',0,200);
cgtext('to the appropriate location on the line. Once you have moved the cursor,',0,150);
cgtext('press the mouse button to make your rating.',0,100);
cgtext('Press any mouse button to continue.',0,-250);
cgflip(0,0,0);
wait(data.time.instructiontime); mp=0; while mp == 0, [~, ~, ~, mp] = cgmouse; end;
[rating, randstart, rt ] = happy_rating('lifehappy', data.time.ratewait);
data.lifehappy.rating = rating;
data.lifehappy.randstart = randstart;
data.lifehappy.rt = rt;


%complete instructions for experiment, do 60 practice trials
rewardSWB_instructions(data);
data.pracdata = rewardSWB_practice(data); %60 trials for no money


%collect baseline data
cgpencol(1,1,1);
cgtext('Before, you were asked to think about your life overall.',0,300);
cgtext('Now, think about just right now. How happy are you at this moment?',0,250);
cgtext('During the task you will be asked this question many times.',0,150);
cgtext('It is VERY important that you use as much of the rating scale as',0,100);
cgtext('you can. The least happy you remember being during the practice',0,50);
cgtext('session you just completed should correspond to somewhere in the',0,0);
cgtext('left half of the rating scale. The most happy you remember being',0,-50);
cgtext('should correspond to somewhere in the right half.',0,-100);
cgtext('Press any mouse button to continue.',0,-300);
cgflip(0,0,0);
wait(data.time.instructiontime); mp=0; while mp == 0, [~, ~, ~, mp] = cgmouse; end;
[rating, randstart, rt ] = happy_rating('nowhappy', data.time.ratewait);
data.basehappy.rating = rating;
data.basehappy.randstart = randstart;
data.basehappy.rt = rt;





%%%%do 150 trials of actual experiment for real money with 61 ratings
%doesnt save anything until it starts collecting data from the experiment.

data = rewardSWB_expt(data);  %mouse - should take 20min

settextstyle(fontName,fontSize);
cgtext('Thank you for participating in this task.',0,-200);
cgtext('Please call the experimenter.',0,-250);
cgtext('Press any mouse button to end the task.',0,-300);
cgflip(0,0,0); 
wait(data.time.instructiontime); mp=0; while mp == 0, [~, ~, ~, mp] = cgmouse; end;
data.endtime = datestr(now,'HH:MM:SS');
eval(sprintf('save %s data',fullfile(data.dir,data.filename))); %save data
fprintf('%.fend\n',data.totalcash*100); %print earnings in pence to screen including £10 endowment

stop_cogent;