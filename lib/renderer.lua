--[[
    Renderer for Launchpads. Calls into shado for values.
    Slightly tricky if we want to support 9x9 (so that
    we can use the live and scene buttons).
    For now: monochrome support only, so we hard-wire
    to orange (homage to the original monome grid).
]]

local spectra = require "launchpads.lib.device"

local function level(renderable, x, y)
    local f = renderable:getLamp(x, y):againstBlack()
    return math.floor(f * 3.0)
end

local function render(renderable)
    -- Main grid:
    for y = 2, 9 do         -- Allow for the live button row.
        for x = 1, 8, 2 do  -- Stride of 2 in "rapid" mode.
            local level_1 = level(renderable, x, y)
            local level_2 = level(renderable, x + 1, y)

            device.note(
                device.data_byte(level_1, level_1),     --  Orange (G=R).
                device.data_byte(level_2, level_2),     --  do.
                3                                       --  Ch 3 == 2-up.
            )
        end
        
        -- Live and scene LEDs.
        -- ...
        -- Reset device output position by pinging a ch=1 note (top-left):
        local l = level(renderable, 1, 2)
        device.note(0, device.data_byte(l, l), 1)
    end
end

return {
    render = render
}
