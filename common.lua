local Messager = {}}
Messager.__index = Messager

function Messager.new( ... )
    local o = {}
    setmetatable(o, Messager)
    return o
end

function Messager.Run(func, ...)
    self.co = coroutine.create( func )
    local ok, err_msg = pcall(coroutine.resume( self.co, ... ))
    if ok then
        error(err_msg)
    end
    return coroutine.yield()
end
