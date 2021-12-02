horizontal, vertical, aim = 0, 0, 0
for line in eachline()
    direction, size_string = split(line)
    size_int = parse(Int, size_string)
    if direction == "forward"
        global horizontal += size_int
        global vertical += aim * size_int
    elseif direction == "down"
        global aim += size_int
    elseif direction == "up"
        global aim -= size_int
    end
end
println(horizontal * aim)
println(horizontal * vertical)
