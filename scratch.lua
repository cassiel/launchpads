-- Tests for Novation Launchpad mini (mk 2 and mk 3).

local inspect = require "launchpads.inspect"
local my_midi

function init()
    my_midi = midi.connect(1)
    
    my_midi.event = function(data)
        local msg = midi.to_msg(data)
        print(inspect.inspect(msg))
        
        my_midi:send(data)
    end
end
