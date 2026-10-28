local M = {}

M.tasks = {}

function M.start(fn)
    local co = coroutine.create(fn)
    table.insert(M.tasks, co)
    return co
end

function M.update(dt)
    for i = #M.tasks, 1, -1 do
        local co = M.tasks[i]
        if coroutine.status(co) == "dead" then
            table.remove(M.tasks, i)
        else
            local ok, err = coroutine.resume(co, dt)
            if not ok then
                print("Coroutine error:", err)
                table.remove(M.tasks, i)
            end
        end
    end
end

function M.wait(seconds)
    local t = 0
    while t < seconds do
        local dt = coroutine.yield() or 0
        t = t + dt
    end
end

-- yield() und resume() wirken gegeneinander als Mailbox, Übergabeparameter sind etwas kontraintuitiv

return M