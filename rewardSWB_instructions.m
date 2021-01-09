function rewardSWB_instructions(data)

mintime = data.time.instructiontime; %5000

[~,~,~,mp]=cgmouse;

cgpencol(1,1,1); 
cgtext('In this task, you will make choices between certain amounts',0,300);
cgtext('of money and gambles with a variety of possible gains and losses.',0,250);
cgtext('You will now make some practice choices. These choices DO NOT',0,200);
cgtext('count for real money.',0,150);
cgtext('Press any mouse button to continue.',0,-300);
cgflip(0,0,0); wait(mintime); 
[~,~,~,mp]=cgmouse; mp=0; while mp==0, [~,~,~,mp]=cgmouse; end;

cgpencol(1,1,1);
cgtext('A gamble looks like this. You can think of each gamble as a coin flip,',0,300);
cgtext('with different outcomes for Heads or Tails. This gamble represents',0,250);
cgtext('a 50% chance of gaining £0.80 and a 50% chance of losing £0.40.',0,200);
cgtext('Practice choice - not for real money.',0,-250);
cgtext('Press any mouse button to make a practice choice.',0,-300);
cgtext('+', 0, 0); cgrect(150,80,150,150); cgrect(150,-80,150,150);
cgpencol(0,0,0); cgtext('+£0.80',150,80); cgtext('-£0.40',150,-80);
cgflip(0,0,0); wait(mintime); 
[~,~,~,mp]=cgmouse; mp=0; while mp==0, [~,~,~,mp]=cgmouse; end;

cgpencol(1,1,1);
cgtext('Would you prefer £0 or a gamble with a 50% chance of gaining £0.80',0,300);
cgtext('and a 50% chance of losing £0.40?',0,250);
cgtext('Practice choice - not for real money.',0,-250);
cgtext('Press the right mouse button to see what happens if you choose to gamble.',0,-300);
cgtext('+', 0, 0); cgrect(-150,0,150,150); cgrect(150,80,150,150); cgrect(150,-80,150,150);
cgpencol(0,0,0); cgtext('£0',-150,0); cgtext('+£0.80',150,80); cgtext('-£0.40',150,-80);
cgflip(0,0,0); wait(mintime); 
[~,~,~,mp]=cgmouse; mp=0; while mp~=4, [~,~,~,mp]=cgmouse; end; %right click

cgpencol(1,1,1);
cgtext('You chose the gamble, a 50% chance of gaining £0.80 and a 50% chance',0,300);
cgtext('of losing £0.40.',0,250);
cgtext('Practice choice - not for real money.',0,-250);
cgtext('Press any mouse button to continue.',0,-300);
cgtext('+', 0, 0); cgrect(150,80,150,150); cgrect(150,-80,150,150);
cgpencol(0,0,0); cgtext('+£0.80',150,80); cgtext('-£0.40',150,-80);
cgflip(0,0,0); wait(mintime); 
[~,~,~,mp]=cgmouse; mp=0; while mp==0, [~,~,~,mp]=cgmouse; end;

cgpencol(1,1,1);
cgtext('The outcome of the gamble is then shown. This is what it would look',0,300);
cgtext('like if the outcome had been gaining £0.80.',0,250);
cgtext('Practice choice - not for real money.',0,-250);
cgtext('Press any mouse button to continue.',0,-300);
cgtext('+', 0, 0); cgrect(150,80,150,150);
cgpencol(0,0,0); cgtext('+£0.80',150,80);
cgflip(0,0,0); wait(mintime); 
[~,~,~,mp]=cgmouse; mp=0; while mp==0, [~,~,~,mp]=cgmouse; end;

cgpencol(1,1,1);
cgtext('Some choices, like the one you just made, involve both gains and losses.',0,300);
cgtext('Other choices involve only gains or only losses.',0,250);
cgtext('Press any mouse button to make another practice choice.',0,-300);
cgflip(0,0,0); wait(mintime); 
[~,~,~,mp]=cgmouse; mp=0; while mp==0, [~,~,~,mp]=cgmouse; end;

cgpencol(1,1,1);
cgtext('Would you prefer to lose £0.20 for sure or a gamble with a 50% chance',0,300);
cgtext('of getting £0 and a 50% chance of losing £0.50.',0,250);
cgtext('Practice choice - not for real money.',0,-250);
cgtext('Press the left mouse button to see what happens if you choose the certain amount.',0,-300);
cgtext('+', 0, 0); cgrect(-150,0,150,150); cgrect(150,80,150,150); cgrect(150,-80,150,150);
cgpencol(0,0,0); cgtext('-£0.20',-150,0); cgtext('£0',150,80); cgtext('-£0.50',150,-80);
cgflip(0,0,0); wait(mintime); 
[~,~,~,mp]=cgmouse; mp=0; while mp~=1, [~,~,~,mp]=cgmouse; end;

cgpencol(1,1,1);
cgtext('You chose the certain amount, losing £0.20 for sure.',0,300);
cgtext('If you had chosen the gamble, you would see your choice and then',0,250);
cgtext('the gamble outcome.',0,200);
cgtext('Practice choice - not for real money.',0,-250);
cgtext('Press any mouse button to make another practice choice.',0,-300);
cgtext('+', 0, 0); cgrect(-150,0,150,150);
cgpencol(0,0,0); cgtext('-£0.20',-150,0);
cgflip(0,0,0); wait(mintime); 
[~,~,~,mp]=cgmouse; mp=0; while mp==0, [~,~,~,mp]=cgmouse; end;

cgpencol(1,1,1);
cgtext('Would you prefer to gain £0.40 for sure or a gamble with a 50% chance',0,300);
cgtext('of gaining £0.40 and a 50% chance of getting £0.',0,250);
cgtext('Practice choice - not for real money.',0,-250);
cgtext('Press the right mouse button to see what happens if you choose the certain amount.',0,-300);
cgtext('+', 0, 0); cgrect(150,0,150,150); cgrect(-150,80,150,150); cgrect(-150,-80,150,150);
cgpencol(0,0,0); cgtext('+£0.40',150,0); cgtext('+£0.40',-150,80); cgtext('£0',-150,-80);
cgflip(0,0,0); wait(mintime); 
[~,~,~,mp]=cgmouse; mp=0; while mp~=4, [~,~,~,mp]=cgmouse; end;

cgpencol(1,1,1);
cgtext('You chose the certain amount, gaining £0.40 for sure. If you had chosen the',0,300);
cgtext('gamble, you would see your choice and then the gamble outcome. Make your',0,250);
cgtext('choices carefully. Choosing the gamble here would have been a mistake because',0,200);
cgtext('the best outcome from the gamble (£0.40) was the same as the certain amount.',0,150);
cgtext('Practice choice - not for real money.',0,-250);
cgtext('Press any mouse button to continue.',0,-300);
cgtext('+', 0, 0); cgrect(150,0,150,150);
cgpencol(0,0,0); cgtext('+£0.40',150,0);
cgflip(0,0,0); wait(mintime); 
[~,~,~,mp]=cgmouse; mp=0; while mp==0, [~,~,~,mp]=cgmouse; end;

cgpencol(1,1,1);
cgtext('You will now complete a practice session which DOES NOT',0,300);
cgtext('count for real money. You will have as long as you need to make your',0,250);
cgtext('choices but try to make your choices as quickly as you can.',0,200);
cgtext('During the practice session, how much money you WOULD HAVE earned',0,150);
cgtext('if you were in the experiment will be displayed on the screen.',0,100);
cgtext('All gambles have a 50% chance of each outcome. The computer picks',0,50);
cgtext('random numbers to determine the outcome of gambles. Your earnings',0,0);
cgtext('depend both on your choices and on your luck.',0,-50);
cgtext('Press any button to start the practice session.',0,-300);
cgflip(0,0,0); wait(mintime); 
[~,~,~,mp]=cgmouse; mp=0; while mp==0, [~,~,~,mp]=cgmouse; end;
