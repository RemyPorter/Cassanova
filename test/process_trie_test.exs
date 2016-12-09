defmodule TestProcessTrie do
    use ExUnit.Case, async: true

    setup context do
        case Process.whereis(:trie) do
            nil -> nil
            pid -> Process.unregister(:trie)
                Process.exit(pid, :kill)
        end
        {:ok, pid} = Task.start(ProcessTrie, :start, [])
        Process.register(pid, :trie)
        :ok
    end

    test "adds items asynchronously" do
        pid = Process.whereis(:trie)
        :ok = ProcessTrie.add(pid, self(), [:a, :a1, :a11])
        :ok = ProcessTrie.all(pid, self())
        added = receive do
            {:add, :ok} -> :ok
        after
            1_000 -> :fail
        end

        result = receive do
            {:all, :ok, trie} -> trie
        after
            1_000 -> :fail
        end

        assert(result == %{a: %{a1: %{a11: %{}}}} and added == :ok)
    end

    test "deletes items asynchronously" do
        pid = Process.whereis(:trie)
        :ok = ProcessTrie.add(pid, self(), [:a, :a1, :a11])
        :ok = ProcessTrie.delete(pid, self(), [:a, :a1])
        :ok = ProcessTrie.all(pid, self())
        deleted = receive do
            {:delete, :ok} -> :ok
        after
            1_000 -> :fail
        end

        result = receive do
            {:all, :ok, trie} -> trie
        after
            1_000 -> :fail
        end

        assert(result == %{a: %{}} and deleted == :ok)
    end
end