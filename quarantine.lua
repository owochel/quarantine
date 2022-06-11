


-- title:  quarantine, the game
-- author: shuang cai and Leffin
-- desc:   survival game. WIP
-- script: lua
t=3600 --ingame TIC starts at 6am
irl_t=0--ingame time
x=111
y=63
day=1

health=51000
hunger=51000
sanity=51000
wealth=100000
--player info

playerState="none"

state="title"

nInstruction=1

flip=0
spent=true--one time purchase boolean
textP={x=10,y=5,c=12}

buttonState="start"

dailyRandom=math.random()
eventT=0
shake=10
reason="none"


loop=0

popEvent={n=true,poop=false,insomnia=false,shopping=false,zoom=false,check=false,x=8,y=32}

sin,cos,asin,sqrt,rnd,pi=math.sin,math.cos,math.asin,math.sqrt,math.random,math.pi

-- cloud1

tc=0
cc=0
mc=0

cloud={}

function TIC()
	playerMove()
	if day>=15 then
		nDepress()
		state="win"
		t=3600 --ingame TIC starts at 6am
		irl_t=0--ingame time
		x=111
		y=63
		day=1
		health=51000
		hunger=51000
		sanity=51000
		wealth=100000
		loop=0
		eventT=0

		nInstruction=1
	end

	if state=="die" then
		die()
	end
	if state=="title" then
		title()
	end
	if state=="win" then
		win()
	end
	if state=="start" then
		start()
	end
	if state=="instruction" then
		instruction()
	end
	-- mx,my,p=mouse()
	
 --     print("x ".. x,5,110,textP.c)
 --     print("y " .. y,5,120,textP.c)
     -- print("mx " .. mx,40,110,textP.c)
     -- print("my " .. my,40,120,textP.c)
     -- print("state ".. state,5,90,textP)
     -- print("zoom ".. popEvent.zoom,5,90,textP)
     -- print("nInstruction ".. nInstruction,5,90,textP)

end



function gameOver(deathState)
	local s=""
	nDepress()
	state="die"
	t=3600 --ingame TIC starts at 6am
	irl_t=0--ingame time
	x=111
	y=63
	day=1
	health=51000
	hunger=51000
	sanity=51000
	wealth=100000
	loop=0
	eventT=0
	reason=deathState
end

function die()
	cls(10)
	winCloud()
	loop=loop+1/10
	spr(256,111,90-loop,5,1,flip,0,1,1)
	spr(277,111,82-loop,5,1,flip,0,1,1)
	if key(64) then
		x=40
		y=70
		state="title"
	end

	if reason=="sanity" then
		print("You have lost your mind in Quarantine.",textP.x,textP.y-loop+100,0)
		if day>1 then
			print("The past " .. day .. " days have driven you crazy.",textP.x,textP.y-loop+120,0)
		else 
			print("The past 1 day has driven you crazy.",textP.x,textP.y-loop+120,0)
		end
		print("This ending is meant to remind you that",textP.x,textP.y-loop+140,0)
		print("you are always loved and cared for.",textP.x,textP.y-loop+160,0)
		print("So please take care of youreslf.",textP.x,textP.y-loop+180,0)
		print("Don't give up. It'll be better in real life",textP.x,textP.y-loop+200,0)
		print("and next time you play this game.",textP.x,textP.y-loop+220,0)
	end

	if reason=="health" then
		print("You got sick.",textP.x,textP.y-loop+100,0)
		if day>1 then
			print("You neglected your health in the past " .. day .. " days.",textP.x,textP.y-loop+120,0)
		else 
			print("You neglected your health in the past day.",textP.x,textP.y-loop+120,0)
		end
		print("This ending is meant to remind you to",textP.x,textP.y-loop+140,0)
		print("eat some good food and exercise more.",textP.x,textP.y-loop+160,0)
		print("Too much gaming is also bad.",textP.x,textP.y-loop+180,0)
		print("Don't give up. It'll be better in real life",textP.x,textP.y-loop+200,0)
		print("and next time you play this game.",textP.x,textP.y-loop+220,0)
	end
	if reason=="hunger&wealth" then
		print("It is hard to work in Quarantine.",textP.x,textP.y-loop+100,0)
		if day>1 then
			print("After " .. day .. " days of chilling,",textP.x,textP.y-loop+120,0)
		else 
			print("After 1 day of chilling,",textP.x,textP.y-loop+120,0)
		end
		print("you cannot even afford a proper meal.",textP.x,textP.y-loop+140,0)
		print("Capitalism is the true monster.",textP.x,textP.y-loop+160,0)
		print("This ending is meant to remind you that",textP.x,textP.y-loop+180,0)
		print("don't give up. It'll be better in real life",textP.x,textP.y-loop+200,0)
		print("and next time you play this game.",textP.x,textP.y-loop+220,0)
	end

	if reason=="hunger" then
		print("You starved youreslf.",textP.x,textP.y-loop+100,0)
		if day>1 then
			print("You neglected to eat in the past " .. day .. " days.",textP.x,textP.y-loop+120,0)
		else 
			print("You didn't eat at all the 1st day.",textP.x,textP.y-loop+120,0)
		end
		print("You have enough money though.",textP.x,textP.y-loop+140,0)
		print("So you probably just forgot.",textP.x,textP.y-loop+160,0)
		print("This ending is meant to remind you that",textP.x,textP.y-loop+180,0)
		print("don't forget to eat & take care",textP.x,textP.y-loop+200,0)
		print("and next time you play this game.",textP.x,textP.y-loop+220,0)
	end


	if loop > 200 then
		print("Press SHIFT to restart",65,85,12)
		print("Press SHIFT to restart",64,84,0)
		print("Quarantine",65,39,12,false,2,false)
		print("Quarantine",64,38,0,false,2,false)
	end
end

function win()
	cls(10)
	winCloud()
	loop=loop+1/10
	if key(64) then
			x=40
			y=70
			state="title"
	end
	print("14 days of Quarantine has passed.",textP.x,textP.y-loop+100,0)
	print("You are released back to the society.",textP.x,textP.y-loop+120,0)
	print("Whether it has been pleasant or not,",textP.x,textP.y-loop+140,0)
	print("you did your part to keep COVID away.",textP.x,textP.y-loop+160,0)
	print("Thank you for that.",textP.x,textP.y-loop+180,0)

	if loop > 190 then
	print("Press SHIFT to restart",65,85,12)
	print("Press SHIFT to restart",64,84,0)
	print("Quarantine",65,39,12,false,2,false)
	print("Quarantine",64,38,0,false,2,false)

	end
end


function title()
	map(0,18,30,17,0,0,5)
	spr(256,x,y,5,1,flip,0,1,1)
	line(x,y+8,x+7,y+8,11)
	line(x+1,y+9,x+6,y+9,11)

	if x<=3 then x=3 end
	if x>=229 then x =229 end
	if y>=124 then y=124 end
	if y<=3 then y=3 end

	if x>56 and x<58 then
		if y>77 and y <90 then
			x = 56
		end
	end
	if x>175 and x<177 then
		if y>77 and y <90 then
			x = 177
		end
	end
	if y>73 and y<75 then
		if x>57 and x <177 then
			y = 73
		end
	end
	if y>90 and y<92 then
		if x>57 and x <177 then
			y = 92
		end
	end


	--print( text [x=0 y=0] [color=12] [fixed=false] [scale=1] [smallfont=false]) -> text width
	local b={12,2}
	local blink=1+loop%80//40
	loop=loop+1
	-- print(blink,5,5)
	--make the color the same as background for blinking
	print("Press ENTER to enter",65,85,b[blink])

	print("Quarantine",65,39,12,false,2,false)
	print("Quarantine",64,38,1,false,2,false)
	if buttonState=="start" then
		print("Start",61,101,12)
		spr(48,52,98,5)
		if btnp(2) or btnp(3) then buttonState="instruction" end
		--key(50) determine if ENTER is hit
		if key(50) then
			x=40
			y=70
			state="start"
		end
	else 
		print("Instruction", 121,101,12)
		spr(48,112,98,5)
		if btnp(2) or btnp(3) then buttonState="start" end
		if key(50) then
			x=40
			y=70
			state="instruction"
		end
	end
		print("Start",60,100,1)
		print("Instruction", 120,100,1)
	end


function instruction()
	local arrInstruction={}
	map(30,0,30,17,0,0,5)
    map(0,0,30,17,0,0,5)
    spr(256,x,y,5,1,flip,0,1,1)
    nightcloud()
    arrInstruction[1]="I'm quarantined here for 14 days.."
	arrInstruction[2]="I should keep track of.."
	arrInstruction[3]="all aspects of my life.."
	arrInstruction[4]="by doing things properly.."
	arrInstruction[7]="The right is status metrics."
	arrInstruction[8]="The left is event notifications."
	arrInstruction[9]="This icon means you need to poop."
	arrInstruction[10]="This means you are insomniacs."
	arrInstruction[11]="This means your packages arrived."
	arrInstruction[12]="This means you have a work meeting."   	
    x=40
	y=70
	print("day" .. " " .. day,textP.x+190,textP.y,textP.c)
	if btnp(3) then
		nInstruction=nInstruction+1
	end
	if btnp(2) then
		nInstruction=nInstruction-1
	end
	if key(64) then
			state="title"
	end
	if nInstruction<1 then nInstruction=9 end
	if nInstruction>13 then nInstruction=1 end

    if nInstruction<5 then
    	popup(arrInstruction[nInstruction],20)
    	if nInstruction<3 then
    		print("Press ARROW keys to see instructions.",textP.x,122,textP.c)
  		end
	end
	if nInstruction==5 then
		map(60,10,23,2,0,0,5)
		print("Here is the story of my life.",textP.x,textP.y,textP.c)
	end
	if nInstruction==6 then
		map(60,12,30,3,0,112,5)
		print("This will tell you what to do.",textP.x,122,textP.c)
	end
	if nInstruction==7 then
		map(64,0,13,10,136,24,5)    	
		popup(arrInstruction[nInstruction],20)
	end
	if nInstruction==8 then
		map(60,0,4,10,0,24,5)
		popup(arrInstruction[nInstruction],20)
	end
	if nInstruction==9 then
		spr(316,popEvent.x,popEvent.y,5,1,0,0,2,2)
		spr(308+t%60//30*2,popEvent.x,popEvent.y,5,1,0,0,2,2)
		popup(arrInstruction[nInstruction],20)
	end

	if nInstruction==10 then
		spr(316,popEvent.x,popEvent.y+16,5,1,0,0,2,2)
		spr(312+t%600//300*2,popEvent.x,popEvent.y+16,5,1,0,0,2,2)
		popup(arrInstruction[nInstruction],20)
	end

	if nInstruction==11 then
		spr(316,popEvent.x,popEvent.y+32,5,1,0,0,2,2)
		spr(342+t%800//400*2,popEvent.x,popEvent.y+32,5,1,0,0,2,2)
		popup(arrInstruction[nInstruction],20)
	end
	if nInstruction==12 then
		spr(316,popEvent.x,popEvent.y+48,5,1,0,0,2,2)

		spr(346+t%300//150*2,popEvent.x,popEvent.y+48,5,1,0,0,2,2)
		popup(arrInstruction[nInstruction],20)
	end

	if nInstruction>12 then
		print("Press SHIFT to go back to title page.",textP.x,122,textP.c)
	end
end


function start()
    map(30,0,30,17,0,0,5)
    map(0,0,30,17,0,0,5)
    -- print(dailyRandom*100,5,30,textP.c)
    -- print(workLikely,5,40,textP.c)
 
    time()
    playerVal()
    if playerState=="none" then
		spr(256,x,y,5,1,flip,0,1,1)
	elseif playerState =="sleep" then
		sleep()
	elseif playerState=="work" then
		work()
	elseif playerState=="exercise" then
		exercise()
		eventT=eventT+1
	elseif playerState=="cook" then
		cook()
		eventT=eventT+1
	elseif playerState=="shower" then
		shower()
		eventT=eventT+1
	elseif playerState=="game" then
		game()
		eventT=eventT+1
	elseif playerState=="poop" then
		toilet()
		eventT=eventT+1
	elseif playerState=="shopping" then
		openBox()
		eventT=eventT+1
	elseif playerState=="meeting" then
		meeting()
		eventT=eventT+1
	end


	if popEvent.poop==true then
		poop()
	end
	if popEvent.insomnia==true then
		insomnia()
	-- 	print("sleepless",20,20,11)
	end
	if popEvent.check==true then
		check()
		eventT=eventT+1
	end

	if popEvent.shopping==true then
		shopping()
	end
	if popEvent.zoom==true then
		zoom()
	end


	if sanity<35000 then
		depress()
		print("day" .. " " .. day,textP.x+190,textP.y,textP.c)
	else
		nDepress()
	end
	if playerState~="cook" then
		if hunger<40000 and hunger> 35000 then
			popup("Food?",20)
		end
		if hunger<30000 and hunger> 25000 then
			popup("Some food maybe?",20)
		end
		if hunger<20000 then
			hungry()
			sanity=sanity-10
			health=health-20
	        popup("I'm starving!",20)
		end
	end

	if (health>100000) then
		health=100000
	end
	if (hunger>100000) then
		hunger=100000
	end
	if (sanity>100000) then
		sanity=100000
	end

	if (sanity<0) then
		gameOver("sanity")
	end
	if (health<0) then
		gameOver("health")
	end
	if hunger<0 and wealth<9000 then
		gameOver("hunger&wealth")
	end
	if hunger<0 and wealth>=9000 then
		gameOver("hunger")

	end

   	room()
end

function playerMove()
	if playerState=="none" then
		if btn(0) then y=y-1 end
		if btn(1) then y=y+1 end
		if btn(2) then x=x-1 flip=1 end
		if btn(3) then x=x+1 flip=0  end
	end

end

function TimeOfDay()
	--helper function to detremine if it is night or not
	hour=irl_t/60
	if hour>19 or hour<7 then
		return "night"
	elseif hour>=7 and hour<12 then
		return "morning"
	elseif hour>=12 and hour<=19 then
		return "afternoon"
	end
end

insomniaLikely=0.2
shoppingLikely=0.5


function time()
	t=t+1
    irl_t=t/10
    health=health-2
    if TimeOfDay()=="night" then
    	sanity=sanity-8
    	health=health-6
    else sanity=sanity-4 end --sanity falls faster at night
    hunger=hunger-10
    if irl_t>=1440 then
        t=0
        day=day+1
        dailyRandom=math.random()
    end
    tim=string.sub(100+math.floor(irl_t/60), 2,3) .. ":" .. string.sub(100+math.floor(irl_t%60),2,3)
    print("Time  " .. tim,158,87,textP.c,true)
    print("day" .. " " .. day,textP.x+190,textP.y,textP.c)
    if irl_t/60>=7 and irl_t/60<=7.5 then
    	popEvent.poop=true
    end
    if irl_t/60>=13 and irl_t/60<=13.5 then
    	popEvent.zoom=true
    end
    if day==7 then 
    	if irl_t/60>=7 and irl_t/60<=7.5 then
    		popEvent.check=true
    	end
    end
    if dailyRandom<insomniaLikely then
    	popEvent.insomnia=true
    else
    	popEvent.insomnia=false
    end
    if dailyRandom<shoppingLikely then
    	popEvent.shopping=true
    else
    	popEvent.shopping=false
    end



    if TimeOfDay()=="night"then
    	nightcloud()
    elseif TimeOfDay()=="morning" then
    	daycloud()
    elseif TimeOfDay()=="afternoon" then
    	suncloud()
    end
    --clock animation
    if ((irl_t/60)>=0 and (irl_t/60)<2) or ((irl_t/60)>=12 and (irl_t/60)<14)  then
    	spr(262,148,85,5)
    elseif ((irl_t/60)>=2 and (irl_t/60)<3) or ((irl_t/60)>=14 and (irl_t/60)<15) then
    	spr(278,148,85,5)
    elseif ((irl_t/60)>=3 and (irl_t/60)<5) or ((irl_t/60)>=15 and (irl_t/60)<17) then
    	spr(294,148,85,5)
    elseif ((irl_t/60)>=5 and (irl_t/60)<6) or ((irl_t/60)>=17 and (irl_t/60)<18) then
    	spr(263,148,85,5)
    elseif ((irl_t/60)>=6 and (irl_t/60)<8) or ((irl_t/60)>=18 and (irl_t/60)<20) then
    	spr(279,148,85,5)
    elseif ((irl_t/60)>=8 and (irl_t/60)<9) or ((irl_t/60)>=20 and (irl_t/60)<21) then
    	spr(295,148,85,5)
    elseif ((irl_t/60)>=9 and (irl_t/60)<11) or ((irl_t/60)>=21 and (irl_t/60)<23) then
    	spr(264,148,85,5)
    elseif ((irl_t/60)>=11 and (irl_t/60)<12) or ((irl_t/60)>=23 and (irl_t/60)<=24) then
    	spr(280,148,85,5)
    end
end

function playerVal()
	if health>50000 then
		spr(258,147,32,5)
	elseif health<=50000 and health> 10000 then
		spr(274,147,32,5)
	elseif health<=10000 then
		spr(290,147,32,5)
	end
	if sanity>50000 then
		spr(259,147,46,5)
	elseif sanity<=50000 and sanity>10000 then
		spr(275,147,46,5)
	elseif sanity<=10000 then
		spr(291,147,46,5)
		popup("I'm so sad...",20)
	end
	if hunger>50000 then
		spr(260,147,59,5)
	elseif hunger<=50000 and hunger> 10000 then
		spr(276,147,59,5)
	elseif hunger<=10000 then
		spr(292,147,59,5)

	end
	spr(261,147,73,5)
	print("Health " .. health//1000,158,34,textP.c,true)
	print("Sanity " .. sanity//1000,158,48,textP.c,true)
	print("Hunger " .. hunger//1000,158,61,textP.c,true)
	print("Wealth " .. wealth//1000,158,74,textP.c,true)
end

function palSwap(c0,c1)
	if(c0==nil and c1==nil)then for i=0,15 do poke4(0x3FF0*2+i,i)end
	else poke4(0x3FF0*2+c0,c1)end
end

function  hungry()
	shake=30
	if shake>0 then
		poke(0x3FF9,math.random(-2,2))
		poke(0x3FF9+1,math.random(-2,2))
		shake=shake-2
		if shake==0 then memset(0x3FF9,0,2) end
	end
end

function getTW(msg)
	-- getting text width
	return print(msg,300,300)

end

function popup(msg, h)
    textW=getTW(msg)+ 6
	-- print(x+8+textW,100,110,textP.c)
	-- print(x-textW,100,115,textP.c)
    if x+8+textW>= 300  then
    	rect (x-textW-1, y-23,textW+2,h+2, 12)
        rect (x-textW, y-22,textW,h, 11)
        print(msg, x-textW+ 3, y-12,12)
    elseif x-textW<=25 then
    	rect (x+7, y-23,textW+2,h+2, 12)
   	    rect (x+8, y-22,textW, h, 11)
        print(msg, x+11, y-12,12,false)
    else 
    	rect (x+7, y-23,textW+2,h+2, 12)
    	rect (x+8, y-22,textW, h, 11)
        print(msg, x+11, y-12,12,false)
    end
end

function depress( )
	palSwap(1,15)
	palSwap(2,13)
	palSwap(11,14)
	-- palSwap(4,8)
	-- palSwap(3,14)
end

function nDepress()
	palSwap()
end


function sleep()
	print("z",43-t%300//150*2,45-t%500//100*2,textP.c)
	spr(272,40,40,5,1,0,0,2,2)    
	health=health+10
    hunger=hunger-3
    t=t+15
    workLikely=workLikely-0.000001
    if TimeOfDay()=="night" then
    	sanity=sanity+10
    	health=health+15
    else
    	sanity=sanity+2
    	insomniaLikely=insomniaLikely+0.001
    end
    if popEvent.insomnia==true then
    	playerState="none"
    end
	if key(64) then
		playerState="none"
	end
end

workLikely=0.6

function work()
	spr(304+t%60//30*2,64,40,5,1,0,0,2,2)
	t=t+5
	if dailyRandom>workLikely then
		print("It is such a productive day.",textP.x,textP.y,textP.c) 
		sanity=sanity+10
	else
		print("I just want to get out.",textP.x,textP.y,textP.c)  
		sanity = sanity-10 
	end
	wealth=wealth+15
	hunger=hunger-5
	if key(64) then
		playerState="none"
	end
	workLikely=workLikely+0.00001
	shoppingLikely=shoppingLikely+0.0001
end


function exercise()
	--print(eventT,5,50,textP.c)
	spr(256,x,y+t%60//30*2,5,1,flip,0,1,1)
	sanity=sanity+10
	health=health+4
	hunger=hunger-10
	insomniaLikely=insomniaLikely-0.002
	if eventT>300 and eventT<=600 then
		print("One last set!",textP.x,textP.y,textP.c) 
		sanity=sanity+2
	elseif eventT>600 then
		print("What's the point...",textP.x,textP.y,textP.c)
		sanity=sanity-15
		health=health-5
	else 
		sanity=sanity+5
		if dailyRandom>0.5 then
			print("I'm so glad I'm doing this.",textP.x,textP.y,textP.c)
		else
			print("Imma be so ripped when I'm out.",textP.x,textP.y,textP.c) 
		end	
	end
	if key(64) then
		playerState="none"
		eventT=0
	end
end

function cook()
	--print(eventT,5,50,textP.c)
	if wealth>30000 then
		print("Yummm...",textP.x,textP.y,textP.c) 
		sanity=sanity+10
	elseif wealth<=30000 then
		print("I might need to cut spending.",textP.x,textP.y,textP.c)
		sanity=sanity+5
	end
	if eventT==300 then
		while spent do
			wealth=wealth-9000
			shoppingLikely=shoppingLikely-0.0005
			hunger=hunger+30000
			spent=false
		end
	end
	spr(257,98+t%60//30*2,48,5)
	if eventT>300 then
		playerState="none"
		eventT=0
	end
end

function shower()
	spr(336+t%60//30*2,96,88,5,1,false,0,2,2)
	health=health+10
	insomniaLikely=insomniaLikely-0.002
	if eventT>300 then
		print("My skin is getting wrinkly.",textP.x,textP.y,textP.c) 
		sanity=sanity-10
	else 
		if dailyRandom>0.5 then
			print("Hey! Mr. Ducky.",textP.x,textP.y,textP.c) 
		else
			print("Ahhh~",textP.x,textP.y,textP.c) 
		end
		sanity=sanity+10
	end
	if key(64) then
		playerState="none"
		eventT=0
	end
end


function openBox()
	spr(372+t%60//30*2,80,73,5,1,false,0,2,2)
	print("I've spent the money.",textP.x,textP.y,textP.c) 
	print("Opening package. It'll take a while.",textP.x,122,textP.c)
	if eventT==200 then
		sanity=sanity+5000
		wealth=wealth-5000
		shoppingLikely=shoppingLikely-0.3
	end
	if eventT>200 then
		playerState="none"
		popEvent.shopping=false
		eventT=0
	end	
end


function game()
	-- print(eventT,5,50,textP.c)	
	spr(368+t%60//30*2,48,72,5,1,0,0,2,4)
	t=t+3 
	health=health-1
	hunger=hunger+1
	if eventT>300 and eventT<=600 then
		print("Eh. My eyes are sore.",textP.x,textP.y,textP.c) 
		sanity=sanity+2
	elseif eventT>600 then
		print("D*m* it! How am I not getting it?",textP.x,textP.y,textP.c)
		sanity=sanity-1
		health=health-1
	else 
		sanity=sanity+5
		if dailyRandom>0.5 then
			print("Woah! Rare flowers!",textP.x,textP.y,textP.c)
		else
			print("How to get Dusa to like me?",textP.x,textP.y,textP.c) 
		end	
		sanity=sanity+10
	end
	if key(64) then
		playerState="none"
		eventT=0
	end
end

function poop()
	spr(308+t%60//30*2,popEvent.x,popEvent.y,5,1,0,0,2,2)
	health=health-1
end

function check()
	if irl_t/60<=8.5 and irl_t>=7 then

		popup("A stimulus check!",20)
	else 
		wealth=wealth+50000
		sanity=sanity+10000
		shoppingLikely=shoppingLikely+0.4
		popEvent.check=false
	end
end

function insomnia()
	spr(312+t%600//300*2,popEvent.x,popEvent.y+16,5,1,0,0,2,2)
end

function shopping()
	spr(342+t%800//400*2,popEvent.x,popEvent.y+32,5,1,0,0,2,2)
end

function zoom()
	spr(346+t%300//150*2,popEvent.x,popEvent.y+48,5,1,0,0,2,2)
	sanity=sanity-1
	wealth=wealth-1
end

function exerciseAct()
	local text = "Train my mind or body?"
	if y>=58 and y<=62 and x<=52 then  
		print("Press ENTER to exercise. SHIFT to stop.",textP.x,122,textP.c)
		if key(50) then
			playerState="exercise"
		elseif playerState=="none" then
			print(text,textP.x,textP.y,textP.c) 
		end
	end
end

function toilet()
	print("Phbbbbt...",textP.x,textP.y,textP.c) 
	print("Press ENTER to poop. It'll take a while.",textP.x,122,textP.c)
	spr(340,112,88,5,1,0,0,2,2)
	if eventT==200 then
		health=health+5000
		sanity=sanity+5000
	end
	if eventT>200 then
		playerState="none"
		popEvent.poop=false
		eventT=0
	end	
end

function meeting()
	print("This meeting...",textP.x,textP.y,textP.c) 
	print("In meeting. It'll take a while.",textP.x,122,textP.c)
	spr(304+t%60//30*2,64,40,5,1,0,0,2,2)
	sanity=sanity-1
	if eventT==300 then
		wealth=wealth+5000
		sanity=sanity+2000
	end
	if eventT>300 then
		playerState="none"
		popEvent.zoom=false
		eventT=0
	end	
end


function topAct()
	local slp = "Wish me a good dream..."
	local wrk = "Hardworking. They said..."
	local cok = "I could always eat something."
	local met= "I gotta attend this meeting."
	if y<49  then
		if x< 50 then 
			if popEvent.insomnia==false then
				print("Press ENTER to sleep. SHIFT to wake up.",textP.x,122,textP.c)
				if key(50) then
					playerState="sleep"
				elseif playerState=="none" then
					print(slp,textP.x,textP.y,textP.c) 
				end
			else 
				print("I don't think I can sleep now...",textP.x,textP.y,textP.c) 
				print("Not much to do here.",textP.x,122,textP.c)
			end

		end

		if x>62 and x<73 then 
			if popEvent.zoom==false then
				print("Press ENTER to work. SHIFT to stop.",textP.x,122,textP.c)
				if key(50) then
					playerState="work"
				elseif playerState=="none" then
					print(wrk,textP.x,textP.y,textP.c) 
				end
			else

				if key(50) then
					playerState="meeting"
				elseif playerState=="none" then
					print(met,textP.x,textP.y,textP.c) 
					print("Press ENTER to attend meeting..",textP.x,122,textP.c)
				end
			end
		end
		if x>=95 then 

			print("Press ENTER to cook. It'll take a while.",textP.x,122,textP.c)
			if key(50) then
				playerState="cook"
				spent=true
			elseif playerState=="none" then
				print(cok,textP.x,textP.y,textP.c) 
			end
		end
	end
end


function doormat()
	
	if x<95 and x>73  then
		if y<74 then y=74 end
		if y>79 then y=79 end
		if y>=79 then 
			if playerState =="none" then
				if  popEvent.shopping==false and day>6 then
					print("More than half done.",textP.x,textP.y,textP.c) 
				end
				if  popEvent.shopping==false and day<=6 then
					print("Not yet. Soon..",textP.x,textP.y,textP.c) 
					print("14 days of Quarantine is required.",textP.x,122,textP.c)
				end
				if popEvent.shopping==true then
					if dailyRandom>0.5 then
						print("When did I buy this?",textP.x,textP.y,textP.c)
						print("Press ENTER to pick up package.",textP.x,122,textP.c)
					else
						print("Ah! I've been waiting for this.",textP.x,textP.y,textP.c)
						print("Press ENTER to pick up package.",textP.x,122,textP.c)
					end
					if key(50) then
						playerState="shopping"
					end

				end
			end
		end 
	end
end


function bathroom()
	local shwr = "A hotbath would help.."
	local t="I can hear my bowel movement."
	local nt="Hm, I'm not feeling the poop."
	if x<=112 and x>=110 and y<=76 and  y>60 then
		eventT=eventT+1
		if eventT<150 then
			print("I look ok.",textP.x,textP.y,textP.c)
		else 
			if dailyRandom>0.5 then
				print("Woah, what am I looking at...",textP.x,textP.y,textP.c)
				sanity=sanity+10
			else
				print("I hate how I look.",textP.x,textP.y,textP.c)
				sanity=sanity-10
			end
		end
	elseif playerState=="None" then
		eventT=0
	end


	if x>=112 and y>=95 then
		if playerState=="none" then
			if popEvent.poop==true then 
				print(t,textP.x,textP.y,textP.c) 
				print("Press ENTER to poop. It'll take a while.",textP.x,122,textP.c)
				if key(50) then
					playerState="poop"
				end
			else 
				print(nt,textP.x,textP.y,textP.c) 
				print("Not much to do here.",textP.x,122,textP.c)
			end
		end
	end

	if x>=102 and x<=109 and y>=90 then 
		print("Press ENTER to shower. SHIFT to stop.",textP.x,122,textP.c) 
		if key(50) then
			playerState="shower"
		elseif playerState=="none" then
			print(shwr,textP.x,textP.y,textP.c)
		end
	end
end

function sofa()
		--sofa
	if y>67 and  y<76 then
		if x>42 and x<61 then x=42
		elseif x<62 and x>43 then x=62 end
	end
	if x>45 and x<62 then
		if y<78 and y>66 then 
			y=78
		elseif y>65 and y<77 then y=65 end
		if y>=78 then
			print("Press ENTER to play switch. SHIFT to stop.",textP.x,122,textP.c) 
			if key(50) then
				playerState="game"
			elseif playerState=="none" then
				if dailyRandom>0.5 then
					print("Animal Krossing?",textP.x,textP.y,textP.c)
				else
					print("Speedrun Hates?",textP.x,textP.y,textP.c) 
				end	
			end
		end
	end
end



function  room()
	exerciseAct()
	doormat()
	topAct()
	bathroom()
	sofa()

	if x<40 then x = 40 end--left wall
	if x>120 then x=120 end--right wall
	if y<48 then y=48 end --top wall



	-- places other than hallway
	if y <73 or y>80 then
		if x>72  then
			if  x<95 then x=72
			else
			if x<96 then x=96 end
			end
		end
 		if x < 102  then
			if y>85 and y<=89 then y=85 
			elseif y>90 then y=90 end
		end
		if x>=102 and x<=108 then--bathroom
			if y>86 then
				if x<103 then x=103 end
				if y>=90 then y=90 end
			end
		end
		if x>=108 and y>93 then
			if x<112 then x=112 end
			if y>95 then y =95 end
		end
	end

	--bathroom top wall
	if y>56 and y<75 then
		if x>104 then x=104 end
	end
	if x>105 then
		if y>55 and y <74 then y = 55 end
		if y<76 and y>56 then y = 76 end
		end
	if y>75 then
		if x>112 then x=112 end
	end
 
end

function daycloud()
--spr id x y [colorkey=-1] [scale=1] 
--     [flip=0] [rotate=0] [w=1 h=1]

 	spr(6,40,24,-1,1,t%150//30,0,2,2,2)
	spr(8,64,24,-1,1,t%180//60,0,2,2,2)	
 	spr(7,96,24,-1,1,t%210//70,0,2,2,2)
end

function nightcloud()
	spr(10,40,24,-1,1,t%400//200,0,2,2,2)
	spr(10,64,24,-1,1,t%600//300,0,2,2,2)	
spr(10,96,24,-1,1,t%800//400,0,2,2,2)	
end

	
function suncloud()
 	spr(2,40,24,-1,1,t%150//30,0,2,2,2)
	spr(4,64,24,-1,1,t%180//60,0,2,2,2)	
 	spr(3,96,24,-1,1,t%210//70,0,2,2,2)	
end

--cloud animation inspired by PARALAXE scrolling horizontale by OdiStudio

function addCloud(x,y,color)
 
 local c={}
 c.x=x
 c.y=y
 c.dx=math.random(-30.0,30)/100.0
 c.dy=math.random(-100.0,100.0)/180.0
 c.r=math.random(4,20)
 c.fm=math.random(5)
 c.co=color
 table.insert(cloud,c)
 
end

function ticCloud()
 
 for k,c in pairs(cloud) do
 
  c.x=c.x-c.dx
  c.y=c.y+c.dy
  
  if c.fm==1 then
   circ(c.x-c.r,c.y,c.r,c.co)
   circ(c.x+c.r,c.y,c.r,c.co)
   circ(c.x,c.y-c.r,c.r,c.co)
   elseif c.fm==2 then
    circ(c.x-c.r,c.y-c.r,c.r,c.co)
    circ(c.x-c.r,c.y,c.r,c.co)
    circ(c.x+c.r,c.y,c.r,c.co)
    circ(c.x,c.y-c.r,c.r,c.co)
    circ(c.x,c.y,c.r,c.co)
   elseif c.fm==3 then
    circ(c.x-c.r,c.y,c.r,c.co)
    circ(c.x+c.r,c.y,c.r,c.co)
    circ(c.x,c.y-c.r,c.r,c.co)
    circ(c.x,c.y+c.r,c.r,c.co)
   elseif c.fm==4 then
    circ(c.x,c.y,c.r,c.co)
   elseif c.fm==5 then
    circ(c.x,c.y,c.r,c.co)
    circ(c.x-c.r,c.y,c.r,c.co)
    circ(c.x,c.y-c.r,c.r,c.co)
    circ(c.x+c.r,c.y,c.r,c.co)
    circ(c.x+c.r*2,c.y,c.r,c.co)
    circ(c.x+c.r*2,c.y+c.r,c.r,c.co)
    circ(c.x+c.r*2,c.y-c.r,c.r,c.co)  
  end
  
  if c.x<=-300 
   then table.remove(cloud,k)
  end 
 end
 
end

-- draw winning screen cloud

function winCloud()

 tc=tc+1
   mc=math.random(0,80)

 -- ticCloud1()
 ticCloud()
   
   if tc>=20
    then addCloud(-50,mc,12)
       addCloud(-50,mc,13)
       addCloud(280,mc,12)
       addCloud(280,mc,13)
      tc=0
   end   

end
