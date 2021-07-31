local shakenote = false
local shakehud = false
local susshake = false
local sway = false
local funkysway = false
local spin = false

local originalx = {}
local originaly = {}

function start (song)
	hudX = getHudX()
    hudY = getHudY()
	
	for i = 0, 7 do
		table.insert(originalx, i.x)
		table.insert(originaly, i.y)
	end
end
		--[[
		BTW Lexicord made this modchart

		hi dad
		]]
function update (elapsed)
	local currentBeat = (songPos / 1000)*(bpm/60)
	hudX = getHudX()
    hudY = getHudY()
	if spin == true then
		camHudAngle = camHudAngle + 2
	end
	if shakenote == true then
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 3 * math.sin((currentBeat * 10 + i*0.25) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 3 * math.cos((currentBeat * 10 + i*0.25) * math.pi) + 10, i)
			setActorX(_G['defaultStrum'..i..'X'] + 64 * math.sin((currentBeat + i*0)), i)

		end
	end

	if shakehud == true then
		for i=0,7 do
			setHudPosition(50 * math.sin((currentBeat * 5 + i*0.25) * math.pi), 50 * math.cos((currentBeat * 5 + i*0.25) * math.pi))
			setCamPosition(-50 * math.sin((currentBeat * 5 + i*0.25) * math.pi), -50 * math.cos((currentBeat * 5 + i*0.25) * math.pi))
		end
	end
	if funkysway == true then
		for i=0,7 do
			setActorY(_G['defaultStrum'..i..'Y'] + 10 * math.cos((currentBeat + i*0.45) * math.pi), i)
			tweenPosYAngle(i,getActorY(i) - 50,0,0.5)
			setActorX(_G['defaultStrum'..i..'X'] + 64 * math.sin((currentBeat + i*0)), i)
		end
	end

	if sway == true then
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 64 * math.sin((currentBeat + i*0)), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 10,i)
		end
	end
end
local section

function stepHit(step)
	if step == 1 then
	end
	if step == 255 then
		sway = true
	end
	if step == 512 then
		sway = false
		funkysway = true
		showOnlyStrums = true
	end
	if step == 660 then
		setCamZoom(0.35)
	end
	if step == 664 then
		setCamZoom(0.35)
		camHudAngle = camHudAngle + 180
	end
	if step == 688 then 
		setCamZoom(-0.35)
	end
	if step == 691 then
		setCamZoom(0.35)
		camHudAngle = camHudAngle - 180
	end
	if step == 725 then
		setCamZoom(-0.35)
	end
	if step == 727 then
		setCamZoom(0.35)
		camHudAngle = camHudAngle + 180
	end
	if step == 771 then
		setCamZoom(2)
		camHudAngle = camHudAngle - 180
		camHudAngle = 0
		showOnlyStrums = false
		funkysway = false
		shakenote = true
	end
	if step == 1023 then
		shakenote = false
		funkysway = true
		showOnlyStrums = true
	end
	if step == 1423 then
		setCamZoom(-0.35)	
	end
	if step == 1428 then
		setCamZoom(0.35)
		camHudAngle = camHudAngle + 180
	end
	if step == 1455 then
		setCamZoom(-0.35)	
	end
	if step == 1460 then
		setCamZoom(0.35)
		camHudAngle = camHudAngle - 180
	end
	if step == 1487 then
		setCamZoom(-0.35)
	end
	if step == 1491 then
		setCamZoom(0.35)
		camHudAngle = camHudAngle + 180
	end
	if step == 1520 then
		setCamZoom(-0.35)
	end
	if step == 1523 then
		setCamZoom(0.35)
		camHudAngle = camHudAngle - 180
	end
	if step == 1534 then
		spin = false
		camHudAngle = 0
		showOnlyStrums = false
		sway = true
		sway = false
		setCamZoom(0.35)
	end
end


print("Mod Chart script loaded :)")