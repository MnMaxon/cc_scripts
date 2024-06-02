local basalt = require("basalt")

local function test()
    local frame = basalt.createFrame()
    local button = frame --> Basalt returns an instance of the object on most methods, to make use of "call-chaining"
            :addButton() --> This is an example of call chaining
            :setPosition(4, 4)
            :setText("Click me!")
            :onClick(
                function()
                    basalt.debug("I got clicked!")
                end)

    basalt.autoUpdate()
end

test()