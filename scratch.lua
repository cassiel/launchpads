-- Tests for Novation Launchpad mini (mk 2 and mk 3).

local inspect = require "launchpads.lib.inspect"
local my_midi

local function data_byte(g, r)
    return (g << 4) + (3 << 2) + r
end

function init()
    my_midi = midi.connect(1)
    
    my_midi.event = function(data)
        local msg = midi.to_msg(data)
        print(inspect.inspect(msg))
        
        if msg.type == "note_on" then
            -- Central 8x8:
            for i = 1, 32 do
                my_midi:note_on(
                    data_byte(math.random(0, 3), math.random(0, 3)),
                    data_byte(math.random(0, 3), math.random(0, 3)),
                    3
                )
            end
            
            -- Scenes, top=to-bottom:
            for i = 1, 4 do
                my_midi:note_on(
                    data_byte(i - 1, 0),
                    data_byte(i - 1, 0),
                    3
                )
            end
            
            -- Automap, left-to-right:
            for i = 1, 4 do
                my_midi:note_on(
                    data_byte(0, i - 1),
                    data_byte(0, i - 1),
                    3
                )
            end
            
            -- Need to reset the 2-up mode, so re-transmit
            -- the first button (or, for testing, re-randomise):
            my_midi:note_on(
                0, data_byte(math.random(0, 3), math.random(0, 3)), 1
            )
        else
            my_midi:send(data)
        end
    end
    
    -- Reset:
    my_midi:send(midi.to_data{
        type = "cc",
        ch = 1,
        cc = 0,
        val = 0
    })

    -- X/Y layout:
    my_midi:send(midi.to_data{
        type = "cc",
        ch = 1,
        cc = 0,
        val = 1
    })
end
