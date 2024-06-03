local basalt = require("basalt")
local utils = require("utils")
local cat_path = "data/spatial_categories.txt"

local COL1 = 2
local COL2 = 18

local function get_categories()
    if not fs.exists(cat_path) then
        return {}
    end
    local h = fs.open(cat_path, "r")
    local s = h.readAll()
    h.close()
    return utils.split_str(s, ",")
end

local function save_categories(categories)
    local h = fs.open(cat_path, "w")
    h.write(table.concat(categories, ","))
    h.close()
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
    --:addItem("Item 1")
    --:addItem("Item 2", colors.yellow)
    --:addItem("Item 3", colors.yellow, colors.green)
            :onChange(
            function(self, item)
                basalt.debug("Selected item: ", item.text)
            end)
    for _, cat in ipairs(get_categories()) do
        cat_dropdown:addItem(cat)
    end
    local spatial_label = frame
            :addLabel()
            :setText("Spatial Port: ")
            :setFontSize(1)
            :setPosition(COL1, 8)
    local spatial_dropdown = frame
            :addDropdown()
            :setPosition(COL1, 9)
            :addItem("Item 1")
            :addItem("Item 2", colors.yellow)
            :addItem("Item 3", colors.yellow, colors.green)
            :onChange(
            function(self, item)
                basalt.debug("Selected item: ", item.text)
            end)
    local load_button = frame
            :addButton()
            :setPosition(COL1, 11) -- TODO Move
            :setText("Load")
            :onClick(
            function()
                -- TODO
                basalt.debug("I got clicked!")
            end)
    local unload_button = frame
            :addButton()
            :setPosition(COL1, 15) -- TODO Move
            :setText("Unload")
            :onClick(
            function()
                -- TODO
                basalt.debug("I got clicked!")
            end)
    local category_input = frame
            :addInput()
            :setPosition(COL2, 5) -- TODO Move
            :setInputType("text")
            :setDefaultText("Category")
            :setInputLimit(20)
    local add_button = frame
            :addButton()
            :setPosition(COL2, 7) -- TODO Move
            :setText("Add")
            :onClick(
            function()
                -- TODO
                basalt.debug("I got clicked!")
            end)
    local remove_button = frame
            :addButton()
            :setPosition(COL2, 11) -- TODO Move
            :setText("Remove Cat")
            :onClick(
            function()
                -- TODO
                basalt.debug("I got clicked!")
            end)
    basalt.autoUpdate()
end

test()