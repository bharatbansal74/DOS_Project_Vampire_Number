defmodule Project do
    #IO.puts System.schedulers_online
    [h, t] = System.argv()
    {:ok, gen_pid} = Server.start_link([])
    Vampire.initdistribute(Enum.to_list(String.to_integer(h) .. String.to_integer(t)),gen_pid)
end
 