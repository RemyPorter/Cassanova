defmodule TokenRingTest do
    use ExUnit.Case, async: true

    setup context do
        case Process.whereis(:tokenring) do
            nil -> nil
            pid -> Process.unregister(:tokenring)
                Process.exit(pid, :kill)
        end
        {:ok, pid} = Task.start(TokenRing, :start, [])
        Process.register(pid, :tokenring)
        :ok
    end

    test "can register a new token" do
        pid = Process.whereis(:tokenring)
        my_token = TokenRing.new_token()
        TokenRing.register(pid, self, my_token)
        TokenRing.node_for_token(pid, self, 0)
        {:nodefound, %Token{token: my_token, pid: self}} = receive do
            msg -> msg
        end
        assert(true)
    end
end