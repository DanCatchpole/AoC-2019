const START = 152085
const END = 670283

function hasEqualAdj(num)
    for i = 1:(length(num)-1)
        if num[i] == num[i+1]
            return true
        end
    end
    return false
end

function alwaysIncreasing(num)
    for i = 1:(length(num)-1)
        if parse(Int64, num[i]) > parse(Int64, num[i+1])
            return false
        end
    end
    return true
end

# If it has two of a kind - they must be next to each other due to always increasing
function onlyTwo(num)
    chars = collect(num)
    uniques = unique(chars)
    counts = []
    # for each unique char, count how many there are
    for c in uniques
        push!(counts, length(findall(x -> x == c, chars)))
    end
    # if there is a double!
    return length(findall(x -> x == 2, counts)) >= 1
end


function part1()
    return length(findall(x -> alwaysIncreasing(x) && hasEqualAdj(x), string.(START:END)))
end

function part2()
    return length(findall(x -> alwaysIncreasing(x) && onlyTwo(x), string.(START:END)))
end

@show part1()
@show part2()
