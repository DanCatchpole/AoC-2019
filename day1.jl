function recursive_fuel_reqs(total, next)
    needs = floor(Int64, next / 3) - 2
    if needs > 0
        return recursive_fuel_reqs(total + needs, needs)
    else
        return total
    end
end

# Read file + convert to floats
file_contents = readlines("input/day1.txt")
masses = parse.(Float64, file_contents)

# compute fuel required for each module + sum
fuel_reqs = floor.(Int64, masses ./ 3) .- 2 
part1_ans = sum(fuel_reqs)
@show part1_ans

# compute recursive fuel required for each module + sum
improved_fuel_reqs = recursive_fuel_reqs.(0, masses)
part2_ans = sum(improved_fuel_reqs)
@show part2_ans