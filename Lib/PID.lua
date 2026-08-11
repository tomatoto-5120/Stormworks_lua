function PID(target, current, kp, ki, kd)
    err = target - current
    I = I + err
    d = err - E
    E = err

    return kp * err + ki * I + kd * d
end