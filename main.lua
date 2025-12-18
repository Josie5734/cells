--20 cells
--by josie


 
function _init()
	
	cls()
	
	--frame count
	frame = 0
	--how often to update (in frames)
	update = 30

	--is the automation running
	running = false

	--number of cells
	cellcount = 20 

	--info 
	--[[
	rows start 5 pixels from left edge (at x = 5)
	top row y = 10
	bottom row y = 100
	]]

    --top (current) generation
    currentgen = {
	}
	cgypos = 10 --y height of currentgen row

    --bottom (next) generation
    nextgen = {
	}
	ngypos = 110 --y height of nextgen row

	--fill in dead cells for both generations
	for i=1,20 do
		add(currentgen,0)
		add(nextgen,0)
	end


	--selex: the cursor, position as in boxes, eg 1 = first box, 2 = second
	selexcg = 1 --currentgen
	selexng = 2 --nextgen

	--the current rule being used
	rule = null

end



function _update()

	--global inputs (can be done while paused or running)
	if btnp(2) then update += 5 end --increase update time
	if btnp(3) then update -= 5 end --decrease update time
	if btnp(4) then --toggle automation
		if running == false then --start automation if stopped
			selexcg = 1 --send selexs to start
			selexng = 2
			running = true --start automation
			frame = 1 --start at frame one so it doesnt immediately go
		elseif running == true then --stop automation if started
			running = false
			frame = 0
			selexcg = 1
			selexng = 2
		end
	end

	--state specific logic
	if running == true then --for all things that go whilst automation is running

		--every update time, check rules
		if frame % update == 0 then
		
			move_selex()

			--rules
			currentgen, nextgen, rule = rules() --check the rules

		end 
	
		--iterate frame
		frame += 1
		if frame > 1000 then frame = 0 end --prevent big numbers

	else --for everything that goes whilst automation is paused

		--inputs
		if btnp(1) and running == false then --move selex right
			move_selex()
		end
		if btnp(0) and selexcg != 1 and running == false then --left (only if not at start) 
			selexcg -= 1 selexng -= 1 
		end		

		if btnp(5) then --swap state of selected cell in currentgen
			if currentgen[selexcg] == 1 then currentgen[selexcg] = 0 else currentgen[selexcg] = 1 end
		end

	end


end



function _draw()
	
	cls()

	--row boxes (white outlines)
	draw_rows()

	--selex selector boxes
	draw_selex(((selexcg*5)+(selexcg*1)),cgypos) --top row selex
	draw_selex(((selexng*5)+(selexng*1)),ngypos) --bottom row selex

	--cell states
	draw_cells()

	--rules
	draw_rules()

	--text
	centerprint("current generation",63,cgypos - 8,7)
	centerprint("next generation",63,ngypos - 8,7)

end



--draw functions

--function to draw the outer boxes for both rows of cells
function draw_rows()

	-- 20 boxes, 1 pixel apart, 5 pixel from the left edge, 4x4 pixels
	local x = 5 --xpos
	local ty = cgypos --bottom y
	local by = ngypos --top y
	for i=1,20 do
		rect(x,ty,x+4,ty+4,7) --top row
		rect(x,by,x+4,by+4,7) --bottom row
		x+=6
	end

end

--draw the filled in squares for cells that are in the alive(1) state
function draw_cells()

	for i=1,#currentgen do --for all cells in currentgen

		local x = i*5 + i*1 --get x and y pos
		local y = cgypos

		if currentgen[i] == 1 then --if cell alive
			rectfill(x,y+1,x+2,y+3,14) --draw filled in color
		end
	end

	for i=1,#nextgen do --for all cells in nextgen

		local x = i*5 + i*1 --get x and y pos
		local y = ngypos

		if nextgen[i] == 1 then --if cell alive
			rectfill(x,y+1,x+2,y+3,14) --draw filled in color
		end
	end

end



--print text centered on a mid point
function centerprint(text,mid,y,c)

	print(text,mid-(#text *2),y,c)

end