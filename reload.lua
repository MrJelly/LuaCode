local Messager = require("Messager")

local msg = Messager:new()
local function func( ... )
    print("start")
    msg:Wait("wait")
    print("end")
end
msg:Run(func)
print("msg start")
msg:Send("wait")
print("msg end")