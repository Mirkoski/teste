local rs = peripheral.wrap("left")
local mon = peripheral.wrap("bottom")

mon.setTextScale(0.5)

local function center(text, y)
    local w = mon.getSize()
    local x = math.floor((w - #text) / 2) + 1
    mon.setCursorPos(math.max(1, x), y)
    mon.write(text)
end

local function draw()
    local items = {}

    for _, item in pairs(rs.getItems({})) do
        if item.name:match("^mysticalagriculture:.*_essence$") then
            table.insert(items, item)
        end
    end

    table.sort(items, function(a, b)
        return a.displayName < b.displayName
    end)

    local w, h = mon.getSize()

    mon.clear()

    -- Cabeçalho
    center("MYSTICAL ESSENCES", 1)

    mon.setCursorPos(1, 2)
    mon.write(string.rep("-", w))

    -- Itens
    for n, item in ipairs(items) do
        local y = n + 2

        if y >= h then
            break
        end

        local name = item.displayName
        local amount = tostring(item.count)

        local maxName = w - #amount - 4

        if #name > maxName then
            name = name:sub(1, maxName - 3) .. "..."
        end

        mon.setCursorPos(2, y)
        mon.write(name)

        mon.setCursorPos(w - #amount + 1, y)
        mon.write(amount)
    end

    -- Rodapé
    mon.setCursorPos(1, h)
    mon.write(string.rep("-", w))

    local footer = #items .. " essencias"
    mon.setCursorPos(w - #footer + 1, h)
    mon.write(footer)
end

while true do
    draw()
    sleep(2)
end