local basalt = require("basalt")
local utils = require("utils")
local cat_path = "data/spatial_categories.txt"

local COL1 = 2
local COL2 = 16
local COL3 = 30

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

local function update_categories(dropdown)
    local index = dropdown.getSelectedIndex()
    dropdown:clear()
    for _, cat in ipairs(get_categories()) do
        dropdown:addItem(cat)
    end
    --if val ~= nil then
    --dropdown:selectItem(val)
    --end
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
    update_categories(cat_dropdown)
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
    local cat_up_button = frame
            :addButton()
            :setPosition(COL2, 5)
            :setText("^ Cat. Up")
            :onClick(
            function()
                -- TODO
                basalt.debug("I got clicked!")
            end)
    local cat_down_button = frame
            :addButton()
            :setPosition(COL2, 9)
            :setText("v Cat Dwn")
            :onClick(
            function()
                -- TODO
                basalt.debug("I got clicked!")
            end)
    local remove_button = frame
            :addButton()
            :setPosition(COL2, 13)
            :setText("Remove Cat")
            :onClick(
            function()
                local val = cat_dropdown.getValue()
                basalt.debug("Removing category " .. val.text)
                local categories = get_categories()
                for i, cat in ipairs(categories) do
                    if cat == val.text then
                        table.remove(categories, i)
                        basalt.debug("Removed category " .. val.text)
                        break
                    end
                end
                save_categories(categories)
                update_categories(cat_dropdown)
            end)
    local category_input = frame
            :addInput()
            :setPosition(COL3, 5)
            :setInputType("text")
            :setDefaultText("Category")
            :setInputLimit(20)
    local add_button = frame
            :addButton()
            :setPosition(COL3, 7)
            :setText("Add")
            :onClick(
            function()
                -- TODO
                local cat = category_input.getValue()
                local categories = get_categories()
                if cat == "" then
                    basalt.debug("Category cannot be empty")
                    return
                elseif util.contains(categories, cat) then
                    basalt.debug("Category already exists")
                    return
                end
                basalt.debug("Adding category " .. category_input.getValue())
                table.insert(categories, cat)
                save_categories(categories)
                update_categories(cat_dropdown)
            end)

    basalt.autoUpdate()
end

test()