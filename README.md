# Rutledge-happiness-task
Matlab code to run task used in Rutledge et al (2014) PNAS.

Risky Decision and Happiness Task
Robb Rutledge (January 2021)

Matlab code that uses the Cogent 2000 Matlab Toolbox for the risky decision and happiness task first used in:

Rutledge RB, Skandali N, Dayan P, Dolan RJ (2014) A neural and computational model of momentary subjective well-being. Proceedings of the National Academy of Sciences USA 111, 12252-12257.

Cogent 2000 can be downloaded here: http://www.vislab.ucl.ac.uk/cogent_2000.php - note that unfortunately Windows 10 is not supported. Save the included Matlab functions in the directory you will run the functions from. Cogent needs to be in your Matlab path. The first line of code in rewardSWB curently adds that folder to the path so adjust as needed depending on where the Cogent toolbox has been saved.

Run the experiment with code like the following: rewardSWB('test001');

It should take around half and hour to run through brief instructions and practice and then the 150-trial experiment. From fMRI, slower timing was used. Endowment and reward magnitudes can be adjusted as apporpriate. Payment for performance is not necessary to get the effects we reported and anonymous participnats playing for points on their smartphones had the same results. A break after the practice session could be included so that the experimenter can answer any questions the participant might have. In particular, if participants are asked how they make their choices and they say that they look at the numbers and see whether it is worth the risk, then they probably understand the task. University students should generally be fine with no instruction or talking to experimenter.

The data files stored include the following variables: trial number, gamble side, certain amount, gamble gain, gamble loss, button pressed, gamble chosen, outcome, rt, happy rating, rating start location, happy rt, trial start time, actual trial start time, delay start, outcome start, iti start, trial end, happy start, rate start, iti start, trial end
