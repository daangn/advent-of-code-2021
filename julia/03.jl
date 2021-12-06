function count_bits(chars::AbstractVector{Char})
    c0 = count(c -> c == '0', chars)
    c1 = count(c -> c == '1', chars)
    c0, c1
end

function most_common_bit(chars::AbstractVector{Char})
    c0, c1 = count_bits(chars)
    c0 > c1 ? '0' : '1'
end

function least_common_bit(chars::AbstractVector{Char})
    c0, c1 = count_bits(chars)
    c0 <= c1 ? '0' : '1'
end

function oxygen_generator(chars::AbstractVector{Char})
    chars .== most_common_bit(chars)
end

function co2_scrubber(chars::AbstractVector{Char})
    chars .== least_common_bit(chars)
end

function rating(matrix::AbstractMatrix{Char}, bit_criteria)
    for bit_position in 1:size(matrix, 2)
        index = bit_criteria(matrix[:, bit_position])
        matrix = matrix[index, :]
        if size(matrix, 1) == 1
            return matrix[1, :]
        end
    end
end

function binary_number(chars::AbstractVector{Char})
    s = String(chars)
    parse(Int, s, base = 2)
end

matrix = vcat((permutedims(Vector{Char}(line)) for line in readlines())...)
gamma = binary_number([most_common_bit(col) for col in eachcol(matrix)])
epsilon = binary_number([least_common_bit(col) for col in eachcol(matrix)])
oxygen = binary_number(rating(matrix, oxygen_generator))
co2 = binary_number(rating(matrix, co2_scrubber))
println(gamma * epsilon)
println(oxygen * co2)
