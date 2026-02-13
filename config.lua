-- dcli configuration pointer
-- This file points to the active host configuration
-- The full configuration lives in hosts/MohamedDesktop.lua

-- Active host
return {
    host = dcli.system.hostname(),
}
