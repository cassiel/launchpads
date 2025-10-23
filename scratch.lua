-- Tests for Novation Launchpad mini (mk 2 and mk 3).

local inspect = require "launchpads.inspect"
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
            local v = data_byte(3, 1)
            
            --[[
            my_midi:send(midi.to_data{
                type = "note_on",
                ch = 1,
                note = msg.note,
                vel = v
            })
            ]]
        
            for i = 1, 32 do
                my_midi:send(midi.to_data{
                    type = "note_on",
                    ch = 3,
                    note = data_byte(math.random(0, 3), math.random(0, 3)),
                    vel = data_byte(math.random(0, 3), math.random(0, 3))
                })
            end
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
