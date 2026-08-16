function CircleXY(r, num, Sdg, Edg, Snum, Enum, cx, cy)
    local t = (num - Snum) / (Enum - Snum)
    local deg = Sdg + t * (Edg - Sdg)
    local rad = deg / 360 * math.pi * 2

    local x = cx + r * math.sin(rad)
    local y = cy - r * math.cos(rad)
	
	return x,y
end