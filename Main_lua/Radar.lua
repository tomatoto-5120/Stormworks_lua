require("Lib.NumberBool")

pi=math.pi
pi2=pi*2
sin=math.sin
cos=math.cos
data={}
--delete frame
removeFrame=property.getNumber("remove frame")

function onTick()


	angle=input.getNumber(4)*pi2 --radar rotation
	range=input.getNumber(8) --display range
    --radar data {distance, azimuth , elevation, frame}
	for i=0,7 do
		if input.getBool(i+1) then
			table.insert(data,{input.getNumber(i*4+1),input.getNumber(i*4+2)*pi2,input.getNumber(i*4+3)*pi2,removeFrame})
		end
	end

    --remove echo
	for i=#data,1,-1 do
		data[i][4]=data[i][4]-1
		if data[i][4]<=0 then
			table.remove(data,i)
		end
	end
end

function onDraw()
	local cw,ch,radius,lineX,lineY,echoX,echoY,colorG

	w=screen.getWidth()
	h=screen.getHeight()
	
    --center
	cw=w/2
	ch=h/2
	
    --display radius
	radius=h/2-3
	
    --radar beam 
	lineX=cw+radius*sin(angle)
	lineY=ch-radius*cos(angle)
	
    --draw radar echo
	for i=1,#data do
		if data[i][1]<range then
			echoX=cw+(data[i][1]/range)*radius*sin(data[i][2])
			echoY=ch-(data[i][1]/range)*radius*cos(data[i][2])
			colorG=255*(data[i][4]/removeFrame)
			screen.setColor(0, colorG, 0)
			screen.drawCircleF(echoX,echoY,2)
		end
	end
	
	screen.setColor(0, 255, 0)
	screen.drawText(0,0,string.format("%.0f",range))
	screen.drawCircle(cw,ch,radius)
	screen.drawLine(cw,ch,lineX,lineY)

end

