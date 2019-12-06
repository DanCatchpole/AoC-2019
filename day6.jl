using LightGraphs

function main(file_contents)
    ids = Dict()
    # Convert planet names -> numeric values
    for line in file_contents
        parts = split(line, ")")
        if !haskey(ids, parts[1])
            ids[parts[1]] = length(ids) + 1
        end
        if !haskey(ids, parts[2])
            ids[parts[2]] = length(ids) + 1
        end
    end

    # Build a graph from the nodes
    graph = SimpleGraph(length(ids))

    for line in file_contents
        parts = split(line, ")")
        add_edge!(graph, ids[parts[1]], ids[parts[2]])
    end

    counter = 0
    for (k, _) in ids
        counter += length(a_star(graph, ids[k], ids["COM"]))
    end
    @show part1 = counter;
    @show part2 = (length(a_star(graph, ids["YOU"], ids["SAN"])) - 2)
end

file_contents = readlines("input/day6.txt")
@time main(file_contents)