--code for the selex cursor

--draw the cursor
function draw_selex(x,y)

	if y == cgypos then --if top row

		if x == 19*5+19*1 then --if at box 19
			--draw selex wrapping around to first box
            rect(x-2,y-1,x+20,y+5,10) --end box
            rect(-1,y-1,10,y+5,10) --start box
		elseif x == 20*5+20*1 then --if at box 20
			--draw selex wrapping around first and second box
			rect(x-2,y-1,x+16,y+5,10) --end box
			rect(-1,y-1,16,y+5,10) -- start box
		else --if not at those specific end boxes
			rect(x-2,y-1,x+16,y+5,10) --top row selex
		end

	elseif y == ngypos then --if bottom row

		rect(x-2,y-1,x+4,y+5,10)

	end

end

function move_selex()

	if selexcg == 19 then --if at box 19
			selexcg += 1 --move to 20
			selexng = 1 --wrap nextgen around
	elseif selexcg == 20 then --if at box 20
		selexcg = 1 --reset currentgen
		selexng += 1 --move nextgen

		if running == true then --if automation running
			--move values of nextegn into currengen and reset nextgen
			for i=1,20 do 
				currentgen[i] = nextgen[i]
				nextgen[i] = 0 
			end 
		end
	else --else at any other position
		selexcg += 1 --move both gens
		selexng += 1
	end

end