local Messager = {}
Messager.__index = Messager

local IS_DEBUG = true

function Messager:new( ... )
    local o = {}
    setmetatable(o, Messager)
    return o
end

function Messager:Run(func, ...)
    self.co = coroutine.create( func )
    local result, err_msg = coroutine.resume( self.co, ... )
    if not result then
        print(err_msg)
    end
end

function Messager:Wait(wait_message)
    self.wait_message = wait_message
    if IS_DEBUG then
        print("Wait", wait_message)
    end
    return coroutine.yield()
end

function Messager:Send(send_message, ...)
    if IS_DEBUG then
        print("Receive", send_message, ...)
    end
    if send_message ~= self.wait_message then
        print("Wait ".. self.wait_message, "But Receive " .. send_message)
        print(debug.traceback())
        return
    end
    self.wait_message = nil
    local result, err_msg = coroutine.resume(self.co, ...)
    if not result then
        print(err_msg)
    end
    return result
end
return Messager
