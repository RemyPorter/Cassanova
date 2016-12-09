defmodule ProcessTrie do
    require Trie

    def start() do
        start(%{})
    end

    defp start(trie) do
        {trie, msg, sender} = receive do
            {:add, sender, data} -> {Trie.add(trie, data), {:add, :ok}, sender}
            {:delete, sender, data} -> {Trie.delete(trie, data), {:delete, :ok}, sender}
            {:search, sender, data} -> {trie, {:search, :ok, Trie.search(trie, data)}, sender}
            {:all, sender, nil} -> {trie, {:all, :ok, trie}, sender}
        end
        send(sender, msg)
        start(trie)
    end

    defp send_msg(op, target, sender, data) do
        send(target, {op, sender, data})
    end

    @spec add(pid, pid, list) :: atom
    def add(triepid, sender, data) do
        send_msg(:add, triepid, sender, data)
        :ok
    end

    @spec delete(pid, pid, list) :: atom
    def delete(triepid, sender, data) do
        send_msg(:delete, triepid, sender, data)
        :ok
    end

    @spec search(pid, pid, list) :: atom
    def search(triepid, sender, data) do
        send_msg(:search, triepid, sender, data)
        :ok
    end

    @spec all(pid, pid) :: atom
    def all(triepid, sender) do
        send_msg(:all, triepid, sender, nil)
        :ok
    end
end