local basalt = require("basalt")
local utils = require("utils")
local cat_path = "data/spatial_categories.txt"

-- Manager for Applied Energistics 2 spatial storage

local COL1 = 2
local COL2 = 16
local COL3 = 30

local function update_dropdown(dropdown, vals)
    local val = dropdown.getValue()
    dropdown:clear()
    if vals == nil then
        return
    end
    for i, cat in pairs(vals) do
        dropdown:addItem(cat)
        if val ~= nil and cat == val.text then
            dropdown:selectItem(i)
        end
    end
end

--local function find_peripheral(name)
--    local names = peripheral.getNames()
--    for _, n in ipairs(names) do
--        if string.find(n, name) then
--            return peripheral.wrap(n)
--        end
--    end
--    return nil
--end

local function get_io_port()
    --return find_peripheral("ae2:spatial_io_port")
    -- Only top and left are working correctly
    return peripheral.wrap("left")
end

local function get_storage()
    --return find_peripheral("minecraft:barrel")
    -- Only top and left are working correctly
    return peripheral.wrap("top")
end

local function re_insert_io()
    local io_port = get_io_port()
    io_port.pushItems("left", 2)
end
local function extract_io()
    local io_port = get_io_port()
    io_port.pushItems("top", 2)
end

local function pulse()
    redstone.setOutput("right", true)
    os.sleep(0.05)
    redstone.setOutput("right", false)
end

local function get_stored_table()
    local storage = get_storage()
    local categories = {}
    for slot, item in pairs(storage.list()) do
        local name = storage.getItemDetail(slot).displayName
        if name ~= nil then
            cat_and_name = utils.split_str(name, ".")
            if #cat_and_name == 2 then
                cat = cat_and_name[1]
                name = cat_and_name[2]
            else
                cat = "Misc"
                name = cat_and_name[1]
            end
            categories[cat] = categories[cat] or {}
            table.insert(categories[cat], name)
        end
    end
    return categories
end

local function load_spatial_ui()
    local frame = basalt.createFrame()
    local load_dropdowns

    local title_label = frame
            :addLabel()
            :setText("Spatial Manager")
            :setFontSize(2)
    local cat_label = frame
            :addLabel()
            :setText("Category: ")
            :setFontSize(1)
            :setPosition(COL1, 5)
    local cat_dropdown = frame
            :addDropdown()
            :setPosition(COL1, 6)
            :onChange(
            function(self, item)
                load_dropdowns()
            end)
    local spatial_label = frame
            :addLabel()
            :setText("Spatial Port: ")
            :setFontSize(1)
            :setPosition(COL1, 8)
    local spatial_dropdown = frame
            :addDropdown()
            :setPosition(COL1, 9)
    --:addItem("Item 1")
    --:addItem("Item 2", colors.yellow)
    --:addItem("Item 3", colors.yellow, colors.green)
            :onChange(
            function(self, item)
                load_dropdowns()
            end)
    load_dropdowns = function()
        if get_io_port() == nil then
            basalt.debug("No IO port found left of computer")
            return
        end
        if get_storage() == nil then
            basalt.debug("No storage found above computer")
            return
        end

        local stored_table = get_stored_table()
        --local categories = get_categories()
        local selected_cat = cat_dropdown.getValue()
        local categories = {}
        local spatial_ports = {}

        --if #stored_table == 0 then
        --    return
        --end

        for cat, items in pairs(stored_table) do
            table.insert(categories, cat)
        end
        if selected_cat == nil then
            selected_cat = { text = categories[1] }
        end
        spatial_ports = stored_table[selected_cat.text]
        update_dropdown(cat_dropdown, categories)
        update_dropdown(spatial_dropdown, spatial_ports)
        --local val = cat_dropdown.getValue()
        --if val == nil then
        --    return
        --end
        --local spatial_ports = get_spatial_ports(val.text)
        --update_dropdown(spatial_dropdown, spatial_ports)
    end
    local load_button = frame
            :addButton()
            :setPosition(COL1, 11)
            :setText("Load")
            :onClick(
            function()
                pulse()
                extract_io()
                local cat = cat_dropdown.getValue().text
                local item = spatial_dropdown.getValue().text
                local storage = get_storage()
                local cat_and_name = cat .. "." .. item
                if cat == "Misc" then
                    cat_and_name = item
                end
                local slot = -1
                for i = 1, storage.size() do
                    local detail = storage.getItemDetail(i)
                    if detail ~= nil and detail.displayName == cat_and_name
                    then
                        slot = i
                        break
                    end
                end
                if slot == -1 then
                    basalt.debug("Item not found in storage")
                    return
                end
                os.sleep(0.05)
                storage.pushItems("top", slot)
                pulse()
                re_insert_io()
                load_dropdowns()
            end)
    local unload_button = frame
            :addButton()
            :setPosition(COL1, 15)
            :setText("Unload")
            :onClick(
            function()
                pulse()
                extract_io()
                load_dropdowns()
            end)
    local reload_button = frame
            :addButton()
            :setPosition(COL2, 5)
            :setText("Reload UI")
            :onClick(
            function()
                load_dropdowns()
            end)

    load_dropdowns()
    basalt.autoUpdate()
end

load_spatial_ui()
--get_stored_map()