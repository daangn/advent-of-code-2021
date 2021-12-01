function count_increases(numbers::Vector{Int}, window::Int)
    count(numbers[1:end-window] .< numbers[1+window:end])
end

numbers = [parse(Int, number) for number in readlines()]
println(count_increases(numbers, 1))
println(count_increases(numbers, 3))
