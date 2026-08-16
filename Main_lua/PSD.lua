require("Lib.Draw.CircleXY")

function onTick()
	rps=input.getNumber(5)
end
	
function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()
	
	screen.setColor(255,255,255)
	screen.drawCircle(w/2-5,h/2-4,8)
	screen.drawLine(w/2-5,h/2-4,CircleXY(8,rps,-90,50,0,35,w/2-5,h/2-4))
end