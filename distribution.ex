defmodule Distribution do
    def work(number,parent_pid,gen_pid) do
        [n|fangs] = Vampire.vampire_numbercheck(number)
        if fangs != "" and fangs != [] do
            Server.update(gen_pid,[n|fangs])
        end
        send(parent_pid,{:done})
    end
end