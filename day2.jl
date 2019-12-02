function part1(arr)
    pos = 0;

    while pos < length(arr)
        opcode = arr[(pos + 1)]
        if opcode == 99
            break
        end
        param1 = arr[arr[pos + 2] + 1]
        param2 = arr[arr[pos + 3] + 1]
        store_pos = arr[pos + 4]
        if opcode == 1
            # Add
            arr[store_pos + 1] = param1 + param2
        elseif opcode == 2
            # Multiply
            arr[store_pos + 1] = param1 * param2
        else
            # Shouldn't hit this
            # println("ERR")
            break
        end
        pos = pos + 4
    end
    return arr[1]
end

function part2(arr, need)
    for noun = 0:99
        for verb = 0:99
            working_state = copy(arr)
            
            # "Fix Gravity"
            working_state[2] = noun
            working_state[3] = verb
            
            if part1(working_state) == need
                return 100 * noun + verb;
            end
        end
    end
end

# Read file + convert to Ints
file_contents = readlines("input/day2.txt")[1]
nums = parse.(Int64, split(file_contents, ","))

# "Fix Gravity"
nums[2] = 12;
nums[3] = 2;

@show part1(copy(nums))
@show part2(copy(nums), 19690720)