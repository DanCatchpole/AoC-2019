function get_value(state, param_modes, pos, param_num)
    if param_modes[param_num] == '0'
        val1 = state[state[pos + param_num + 1] + 1]
    else
        val1 = state[pos + param_num + 1]
    end
end

function add!(state, param_modes, pos)
    val1 = get_value(state, param_modes, pos, 1)
    val2 = get_value(state, param_modes, pos, 2)
    store_pos = state[pos + 4]
    state[store_pos + 1] = val1 + val2

    return pos + 4
end

function multiply!(state, param_modes, pos)
    val1 = get_value(state, param_modes, pos, 1)
    val2 = get_value(state, param_modes, pos, 2)
    store_pos = state[pos + 4]
    state[store_pos + 1] = val1 * val2

    return pos + 4
end

function input!(state, param_modes, pos)
    print("> ")
    val = parse(Int64, readline())

    store_pos = state[pos + 2]
    state[store_pos + 1] = val
    return pos + 2
end

function output!(state, param_modes, pos)
    val1 = get_value(state, param_modes, pos, 1)
    println(val1)
    return pos + 2
end

function jump_if_true!(state, param_modes, pos)
    val1 = get_value(state, param_modes, pos, 1)
    val2 = get_value(state, param_modes, pos, 2)

    if val1 != 0
        return val2
    else
        return pos + 3
    end
end

function jump_if_false!(state, param_modes, pos)
    val1 = get_value(state, param_modes, pos, 1)
    val2 = get_value(state, param_modes, pos, 2)

    if val1 == 0
        return val2
    else
        return pos + 3
    end
end

function less_than!(state, param_modes, pos)
    val1 = get_value(state, param_modes, pos, 1)
    val2 = get_value(state, param_modes, pos, 2)
    store_pos = state[pos + 4]

    state[store_pos + 1] = Int64(val1 < val2)
    return pos + 4
end

function equals!(state, param_modes, pos)
    val1 = get_value(state, param_modes, pos, 1)
    val2 = get_value(state, param_modes, pos, 2)
    store_pos = state[pos + 4]

    state[store_pos + 1] = Int64(val1 == val2)
    return pos + 4
end

const OPS = Dict(
    1 => add!, 2 => multiply!, 3 => input!, 4 => output!,
    5 => jump_if_true!, 6 => jump_if_false!, 7 => less_than!, 8 => equals!
)

function execute_intcode(state)
    pos = 0;
    arr = copy(state)
    while pos < length(arr)
        str_op = string("0000", arr[pos + 1])
        opcode = parse(Int64, str_op[(end-1):end])
        param_modes = [str_op[end-2], str_op[end-3], str_op[end-4]]
        
        if opcode == 99
            break
        end
        if haskey(OPS, opcode)
            func = OPS[opcode]
            pos = func(arr, param_modes, pos)
        else
            println("ERR")
            break
        end
    end
    return arr
end

file_contents = readlines("input/day5.txt")[1]
nums = parse.(Int64, split(file_contents, ","))
execute_intcode(nums)