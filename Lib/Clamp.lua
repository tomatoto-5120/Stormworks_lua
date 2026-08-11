function clamp(num, min, max)
    if num > max then
        return max
    end

    if min > num then
        return min
    end

    return num
end