I,E = 0,0
e = math.exp(1)
maxrps = property.getNumber("max rps") + 60
acceleration_ofset = property.getNumber("acceleration_ofset") + 0.6
maxgear = property.getNumber("max gear") + 3

require("Lib.Math.Delta")

require("Lib.debugs.NumberBool")

require("Lib.Math.PID")

require("Lib.Math.Equal")

require("Lib.Math.Clamp")

require("Lib.Math.Pulse")

gear_num = 1
shift_lock = false

function gear(rps, maxgear, reverse)
    local gear_up = false
    local gear_down = false

    -- 変速後、RPSが30未満まで落ちたら再び変速可能
    if shift_lock and rps < 30 then
        shift_lock = false
    end

    if not reverse then

        -- シフトアップ
        if not shift_lock and rps > 40 and gear_num < maxgear then
            gear_num = gear_num + 1
            gear_up = true
            shift_lock = true

        -- シフトダウン
        elseif rps < 18 and gear_num > 1 then
            gear_num = gear_num - 1
            gear_down = true
        end
    end

    local cumulative_rps = (gear_num - 1) * 40 + rps

    return gear_num, gear_up, gear_down, cumulative_rps
end

function onTick()
    local cluch = input.getNumber(1)
    local rps = input.getNumber(2)
    local torque =input.getNumber(3)
    local startkey = input.getBool(1)
    local elec = input.getNumber(4)
    local reverse =input.getBool(2)


    target_rps = clamp(cluch ^ acceleration_ofset * maxrps, 18, 60)

    if Equal(0, cluch) == true then
        target_rps = target_rps - 6
    end

    if elec < 0.2 and Delta(elec) < -0.05 then
        target_rps = PID(0.08, Delta(elec), 60, 0, 1) + target_rps
    end

    local air_power = PID(target_rps, rps, 0.3, 0, 0.08)

    if startkey == false then
        air_power = air_power *0
    end

    gear_num, gear_up, gear_down = gear(rps, maxgear, reverse)

    local fuel_power = clamp(clamp(-0.1 * gear_num + 0.6, 0.25, 0.5) * air_power, -100, 100)

    output.setNumber(1,fuel_power)
    output.setNumber(2,air_power)
    output.setBool(1,startkey)
    output.setNumber(3, gear_num)
    output.setBool(2, gear_up)
    output.setBool(3, gear_down)
end

function onDraw()
    screen.drawText(0, 0, string.format("Target RPS: %.2f", target_rps))
end