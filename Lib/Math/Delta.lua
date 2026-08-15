oldnumber = 0
function Delta(number)
    local out = number - oldnumber
    oldnumber = number
    return out * 60
end