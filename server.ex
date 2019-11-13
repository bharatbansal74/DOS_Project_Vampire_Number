defmodule Server do
    use GenServer

    def start_link(state), do: GenServer.start_link(__MODULE__, state)
    def init(state), do: {:ok,state}
    def update(pid, item), do: GenServer.cast(pid, {:update, item})
    def fetch(pid), do: GenServer.call(pid, :fetch)
    def handle_call(:fetch, _from,state), do: {:reply,state,state}
    def handle_cast({:update,item},state), do: {:noreply, state ++ [item]}

end
