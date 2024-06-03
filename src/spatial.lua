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
    for i, cat in ipairs(vals) do
        dropdown:addItem(cat)
        if val ~= nil and cat == val.text then
            dropdown:selectItem(i)
        end
    end
end

local function get_storage()
    return peripheral.wrap("top")
end

local function get_io_port()
    return peripheral.wrap("top")
end

local function get_stored_table()
    local storage = get_storage()
    local categories = {}
    for slot, item in pairs(storage.list()) do
        local name = storage.getItemDetail(slot).displayName
        print(("%d x %s %s in slot %d"):format(item.count, item.name,name, slot))
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

local function test()
    local frame = basalt.createFrame()
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
                basalt.debug("Selected item: ", item.text)
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
                basalt.debug("Selected item: ", item.text)
            end)
    local function load_dropdowns()
        local stored_table = get_stored_table()
        --local categories = get_categories()
        local selected_cat = cat_dropdown.getValue()
        local categories = {}
        local spatial_ports = {}
        for cat, items in pairs(stored_table) do
            table.insert(categories, cat)
        end
        if selected_cat ~= nil then
            spatial_ports = stored_table[selected_cat.text]
        end
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
                -- TODO
                basalt.debug("I got clicked!")
            end)
    local unload_button = frame
            :addButton()
            :setPosition(COL1, 15)
            :setText("Unload")
            :onClick(
            function()
                -- TODO
                basalt.debug("I got clicked!")
            end)
    local reload_button = frame
            :addButton()
            :setPosition(COL2, 5)
            :setText("Reload UI")
            :onClick(
            function()
                -- TODO
                basalt.debug("I got clicked!")
                load_dropdowns()
                basalt.autoUpdate()
            end)

    load_dropdowns()
    basalt.autoUpdate()
end

test()
--get_stored_map()