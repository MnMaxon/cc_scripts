local basalt = require("basalt")

local function test()
    local frame = basalt.createFrame()
    local title_label = frame:addLabel()
            :setText("Spatial Manager")
            :setFontSize(2)
    local cat_label = frame:addLabel()
            :setText("Category: ")
            :setFontSize(1)
            :setPosition(1, 4)
    local cat_dropdown = frame
            :addDropdown()
            :setPosition(1, 5)
            :addItem("Item 1")
            :addItem("Item 2", colors.yellow)
            :addItem("Item 3", colors.yellow, colors.green)
            :onChange(
            function(self, item)
                basalt.debug("Selected item: ", item.text)
            end)
    local spatial_label = frame:addLabel()
            :setText("Spatial Port: ")
            :setFontSize(1)
            :setPosition(1, 7)
    local spatial_dropdown = frame
            :addDropdown()
            :setPosition(1, 8)
            :addItem("Item 1")
            :addItem("Item 2", colors.yellow)
            :addItem("Item 3", colors.yellow, colors.green)
            :onChange(
            function(self, item)
                basalt.debug("Selected item: ", item.text)
            end)
    local unload_button = frame:addButton()
            :setPosition(4, 9) -- TODO Move
            :setText("Unload")
            :onClick(
            function()
                -- TODO
                basalt.debug("I got clicked!")
            end)
    local add_button = frame:addButton()
            :setPosition(4, 4) -- TODO Move
            :setText("Add")
            :onClick(
            function()
                -- TODO
                basalt.debug("I got clicked!")
            end)
    local remove_button = frame:addButton()
            :setPosition(4, 4) -- TODO Move
            :setText("Remove")
            :onClick(
            function()
                -- TODO
                basalt.debug("I got clicked!")
            end)
    local up_button = frame:addButton()
            :setPosition(4, 4) -- TODO Move
            :setText("^ UP")
            :onClick(
            function()
                -- TODO
                basalt.debug("I got clicked!")
            end)
    local down_button = frame:addButton()
            :setPosition(4, 4) -- TODO Move
            :setText("v DOWN")
            :onClick(
            function()
                -- TODO
                basalt.debug("I got clicked!")
            end)
    basalt.autoUpdate()
end

test()