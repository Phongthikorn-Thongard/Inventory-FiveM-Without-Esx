UP.PrintTable = function(tbl)
    local maxLengths = {}
    for i, row in ipairs(tbl) do
        for j, val in ipairs(row) do
            local len = string.len(tostring(val))
            maxLengths[j] = maxLengths[j] or 0
            if len > maxLengths[j] then
                maxLengths[j] = len
            end
        end
    end

    local rowSeparator = "+"
    local headerSeparator = "+"
    for i, length in ipairs(maxLengths) do
        rowSeparator = rowSeparator .. string.rep("-", length + 2) .. "+"
        headerSeparator = headerSeparator .. string.rep("-", length) .. "+"
    end

    print(rowSeparator)
    for i, row in ipairs(tbl) do
        local line = "| "
        for j, val in ipairs(row) do
            if j == 3 then
                line = line .. string.format("%" .. maxLengths[j] .. "s | ", val)
            else
                line = line .. string.format("%-" .. maxLengths[j] .. "s | ", tostring(val))
            end
        end
        print(line)
        if i == 1 then
            print(rowSeparator)
        end
    end
    print(rowSeparator)

end
