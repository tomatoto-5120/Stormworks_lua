I,E = 0,0
e = math.exp(1)
oldnumber = 0
maxrps = property.getNumber("max rps") + 60
acceleration_ofset = property.getNumber("acceleration_ofset") + 0.6
maxgear = property.getNumber("max gear") + 2

require("Lib.Math.Delta")

require("Lib.debugs.NumberBool")

require("Lib.Math.PID")

require("Lib.Math.Equal")

require("Lib.Math.Clamp")

function gear(rps, maxgear, reverse)
    gear_num = 1
    if Delta(rps) < 1 and gear_num < maxgear and not reverse then
        gear_num = gear_num +1
        gear_up = true
    end

    if rps > 20 and gear_num > 1 and not reverse then
        gear_num = gear_num - 1
        gear_down = true
    end

    return gear_num, gear_up, gear_down
end

function onTick()
    local cluch = input.getNumber(1)
    local rps = input.getNumber(2)
    local torque =input.getNumber(3)
    local startkey = input.getBool(1)
    local elec = input.getNumber(4)
    local reverse =input.getBool(2)


    local target_rps = clamp(cluch ^ acceleration_ofset * maxrps, 18, 60)

    if Equal(0, cluch) == true then
        target_rps = target_rps - 6
    end

    if elec < 0.2 and Delta(elec) < 0 or Delta(elec) < -0.05 then
        target_rps = PID(0.08, Delta(elec), 1.3, 0.0001, 0.8)
    end

    power = PID(target_rps, rps, 0.3, 0, 0.08)

    if startkey == false then
        power = power *0
    end

    gear_num, gear_up, gear_down = gear(rps, maxgear, reverse)

    output.setNumber(1,power)
    output.setNumber(2,target_rps)
    output.setBool(1,startkey)
    output.setNumber(3, gear_num)
    output.setBool(2, gear_up)
    output.setBool(3, gear_down)
end