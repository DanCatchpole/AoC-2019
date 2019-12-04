# [X, Y]
const UP = [0, 1]
const DOWN = [0, -1]
const LEFT = [-1, 0]
const RIGHT = [1, 0]

# Dist away from center
function manhattanDist(p1)
    return abs(p1[1]) + abs(p1[2])
end


function parseDir(d)
    if d == 'U'
        return UP
    elseif d == 'D'
        return DOWN
    elseif d == 'L'
        return LEFT
    else
        return RIGHT
    end
end

# Convert the 'line' to an array of points it goes through
function lineToPoints(line)
    l = [[0, 0]]
    currPos = [0, 0]
    currSteps = 0
    for elem in line
        direction = elem[1]
        amount = parse(Int64, elem[2:end])
        for i = 1:amount
            # Push each step to the array
            push!(l, currPos + i*parseDir(direction))
        end
        # move that amount
        currPos += amount*parseDir(direction);
    end
    # remove [0, 0] - this won't be an intersection
    return l[2:end]
end

function part1(lines)
    center = [0, 0]
    l1 = lineToPoints(lines[1])
    l2 = lineToPoints(lines[2])
   
    intersections = intersect(l1, l2)
    # Get manhattan distance to this intersection
    dists = manhattanDist.(intersections)
    return minimum(dists)

end


function part2(lines)
    center = [0, 0]
    l1 = lineToPoints(lines[1])
    l2 = lineToPoints(lines[2])
   
    intersections = intersect(l1, l2)
    dists = []
    # Find the (first) position in our array,
    # this will be equal to the number of steps we took to get there
    for intersection in intersections
        stepsL1 = findall(x -> x == intersection, l1)[1]
        stepsL2 = findall(x -> x == intersection, l2)[1]
        push!(dists, stepsL1 + stepsL2)
    end
    return minimum(dists)
end


file_contents = readlines("input/day3.txt")
testStr = ["R75,D30,R83,U83,L12,D49,R71,U7,L72","U62,R66,U55,R34,D71,R55,D58,R83"]
lines = split.(file_contents , ",")

@show part1(lines)
@show part2(lines)