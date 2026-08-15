local prevPush = false

function Pulse(push)
    local pulse = push and not prevPush
    prevPush = push
    return pulse
end
