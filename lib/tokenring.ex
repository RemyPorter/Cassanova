defmodule Token do
    defstruct token: "", pid: nil
end

defmodule TokenRing do
    require Murmur

    defp by_token(item1, item2) do
        item1.token > item2.token
    end

    def start() do
        start([])
    end

    defp find_by_token(nodes, token) do
        candidate = Enum.filter(nodes, fn (n) -> n.token > token end)
        case candidate do
            [] -> [res | _] = nodes
                    res
            [res | _] -> res
        end
    end

    def new_token() do
        Murmur.hash_x64_128(:rand.uniform())
    end

    def hash_value(val) do
        Murmur.hash_x64_128(val)
    end

    def start(nodes) do
        next = receive do
            {:register, pid, token} -> Enum.sort(
                [%Token{token: token, pid: pid} | nodes],
                &(by_token/2)
            )
            {:nodefor, token, sender} ->
                send(sender, {:nodefound, find_by_token(nodes, token)})
                nodes
        end
        start(next)
    end

    def register(target, sender, token) do
        send(target, {:register, sender, token})
    end

    def node_for_token(target, sender, token) do
        send(target, {:nodefor, token, sender})
    end
end