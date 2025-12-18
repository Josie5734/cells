--all things related to the rules


--automata rules (returns new tables to overwrite current tables for each gen)
function rules()

	local ct = currentgen --get currentgen into a shorter name
	local ci = selexcg --get currentgen selex into a shorter name
	local nt = nextgen
	local ni = selexng

	local r = null -- current rule 
	
	if ct[ci] == 1 then --rules 8,7,6,5
		
		if ct[ci+1] == 1 and ct[ci+2] == 1 then nt[ni] = 0 r = 8 --rule 8 (1,1,1) = 0
		elseif ct[ci+1] == 1 and ct[ci+2] == 0 then nt[ni] = 0 r = 7 --rule 7 (1,1,0) = 0
		elseif ct[ci+1] == 0 and ct[ci+2] == 1 then nt[ni] = 0 r = 6 --rule 6 (1,0,1) = 0
		elseif ct[ci+1] == 0 and ct[ci+2] == 0 then nt[ni] = 1 r = 5 --rule 5 (1,0,0) = 1
		end
		
	elseif ct[ci] == 0 then --rules 4,3,2,1

		if ct[ci+1] == 1 and ct[ci+2] == 1 then nt[ni] = 1 r = 4 --rule 4 (0,1,1) = 1
		elseif ct[ci+1] == 1 and ct[ci+2] == 0 then nt[ni] = 1 r = 3 --rule 3 (0,1,0) = 1
		elseif ct[ci+1] == 0 and ct[ci+2] == 1 then nt[ni] = 1 r = 2 --rule 2 (0,0,1) = 1
		elseif ct[ci+1] == 0 and ct[ci+2] == 0 then nt[ni] = 0 r = 1 --rule 1 (0,0,0) = 0
		end

	end

	return ct, nt, r --return updates tables and current rule

end



function draw_rules()

    --rules squares are the same size as rows
    --each rule will be 2 squares apart (including spacing pixel) and will be 1 square from the left edge

    local y = 25 --starting y point
    local x = 18 --starting x point

    centerprint("rules",63,y,7)

    y += 12

    --first row with 8,7,6,5
    local n = 8
    for i=1,4 do rule_boxes(x,y,n,rule) x+=24 n -= 1 end 

    y += 30
    x = 18


    --second row with 4,3,2,1
    n = 4
    for i=1,4 do rule_boxes(x,y,n,rule) x+=24 n-= 1 end
    

	--rules are going to be in 2 rows of 4 in the center
	--all positions should start from a variable so the entire block can be shifted if needed
	--left to is decsending like 8,7,6,5. 

end

--draw the boxes for the rules, n is the number write above box, r is the current rule
function rule_boxes(x,y,n,r)

    --numbers
    print(n,x+8,y,7)

    y+=8

    --box outlines + fills
    rect(x,y,x+5,y+5,7) --left
    if n == 8 or n == 7 or n == 6 or n == 5 then
        rectfill(x+1,y+1,x+4,y+4,14)
    end

    rect(x+7,y,x+12,y+5,7) --middle
    if n == 8 or n == 7 or n == 4 or n == 3 then
        rectfill(x+8,y+1,x+11,y+4,14)
    end
    
    rect(x+14,y,x+19,y+5,7) --right
    if n == 8 or n == 6 or n == 4 or n == 2 then
        rectfill(x+15,y+1,x+18,y+4,14)
    end

    rect(x+7,y+7,x+12,y+12,7) --bottom
    if n == 5 or n == 4 or n == 3 or n == 2 then
        rectfill(x+8,y+8,x+11,y+11,14)
    end

    --rule selex
    if r == n then --if current rule is the one being currently drawn
        rect(x-1,y-1,x+20,y+6,10)
    end

end
