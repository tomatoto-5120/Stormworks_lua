function Equal(target, num)
    tol = 1e-4
    b1 = math.abs(num - target) <= tol

    return b1
end