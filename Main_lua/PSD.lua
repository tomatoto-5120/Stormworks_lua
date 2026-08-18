require("Lib.Draw.CircleXY")

require("Lib.debugs.NumberBool")

function onTick()
	rps = input.getNumber(5)
end
	
function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()
	
	screen.setColor(255,255,255)
	screen.drawCircle(9, 9, 8)

	screen.setColor(0,0,0)
	screen.drawRectF(1, 10, 32,9)

	screen.setColor(0, 255, 0)
	screen.drawText(0, 10, string.format("%.1f", rps))
end