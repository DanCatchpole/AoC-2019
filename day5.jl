function add!(state, param_modes, pos)
    if param_modes[1] == '0'
        val1 = state[state[pos + 2] + 1]
    else
        val1 = state[pos + 2]
    end
    if param_modes[2] == '0'
        val2 = state[state[pos+3]+1]
    else
        val2 = state[pos + 3]
    end
    store_pos = state[pos + 4]
    state[store_pos + 1] = val1 + val2

    return pos + 4
end

function multiply!(state, param_modes, pos)
    if param_modes[1] == '0'
        val1 = state[state[pos + 2] + 1]
    else
        val1 = state[pos + 2]
    end
    if param_modes[2] == '0'
        val2 = state[state[pos+3]+1]
    else
        val2 = state[pos + 3]
    end
    store_pos = state[pos + 4]
    state[store_pos + 1] = val1 * val2

    return pos + 4
end

function input!(state, pos)
    store_pos = state[pos + 2]

    print("> ")
    val = parse(Int64, readline())

    state[store_pos + 1] = val
    return pos + 2
end

function output!(state, param_modes, pos)
    if param_modes[1] == '0'
        val1 = state[state[pos + 2] + 1]
    else
        # Use actual value
        val1 = state[pos + 2]
    end

    println(val1)
    return pos + 2
end

function jump_if_true!(state, param_modes, pos)
    if param_modes[1] == '0'
        val1 = state[state[pos + 2] + 1]
    else
        val1 = state[pos + 2]
    end
    if param_modes[2] == '0'
        val2 = state[state[pos + 3] + 1]
    else
        val2 = state[pos + 3]
    end

    if val1 != 0
        return val2
    else
        return pos + 3
    end
end

function jump_if_false!(state, param_modes, pos)
    if param_modes[1] == '0'
        val1 = state[state[pos + 2] + 1]
    else
        val1 = state[pos + 2]
    end
    if param_modes[2] == '0'
        val2 = state[state[pos + 3] + 1]
    else
        val2 = state[pos + 3]
    end

    if val1 == 0
        return val2
    else
        return pos + 3
    end
end

function less_than!(state, param_modes, pos)
    if param_modes[1] == '0'
        val1 = state[state[pos + 2] + 1]
    else
        val1 = state[pos + 2]
    end
    if param_modes[2] == '0'
        val2 = state[state[pos + 3] + 1]
    else
        val2 = state[pos + 3]
    end
    store_pos = state[pos + 4]

    if val1 < val2
        state[store_pos + 1] = 1
    else
        state[store_pos + 1] = 0
    end
    return pos + 4
end

function equals!(state, param_modes, pos)
    if param_modes[1] == '0'
        val1 = state[state[pos + 2] + 1]
    else
        val1 = state[pos + 2]
    end

    if param_modes[2] == '0'
        val2 = state[state[pos + 3] + 1]
    else
        val2 = state[pos + 3]
    end
    store_pos = state[pos + 4]

    if val1 == val2
        state[store_pos + 1] = 1
    else
        state[store_pos + 1] = 0
    end

    return pos + 4
end

function execute_intcode(state)
    pos = 0;
    arr = copy(state)
    while pos < length(arr)
        opcode = arr[pos + 1]
        
        str_rep = string("0000", opcode)
        opcode = parse(Int64, str_rep[(end-1):end])
        param_modes = [str_rep[end-2], str_rep[end-3], str_rep[end-4]]
        
        if opcode == 99
            break
        end
        if opcode == 1 # Add
            pos = add!(arr, param_modes, pos)
        elseif opcode == 2 # Multiply
            pos = multiply!(arr, param_modes, pos)
        elseif opcode == 3 # Take an input
            pos = input!(arr, pos)
        elseif opcode == 4 # Output
            pos = output!(arr, param_modes, pos)
        elseif opcode == 5 # jump-if-true
            pos = jump_if_true!(arr, param_modes, pos)
        elseif opcode == 6 # jump-if-false
            pos = jump_if_false!(arr, param_modes, pos)
        elseif opcode == 7 # less than
            pos = less_than!(arr, param_modes, pos)
        elseif opcode == 8 # equals
            pos = equals!(arr, param_modes, pos)
        else # error
            println("ERR")
            break
        end
    end
    return arr
end

file_contents = readlines("input/day5.txt")[1]
nums = parse.(Int64, split(file_contents, ","))
execute_intcode(nums)