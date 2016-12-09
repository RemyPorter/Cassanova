defmodule TestTrie do
    use ExUnit.Case, async: true

    setup context do
        context = Map.put_new(context, :empty_root, %{})
        context = Map.put_new(context, :simple_tree, %{a: %{a1: %{}, a2: %{}}, b: %{}})
    end

    test "add an empty list", context do
        t = Map.get(context, :simple_tree)
        assert t == Trie.add(t, [])
    end

    test "add a single item", context do
        t = Map.get(context, :empty_root)
        assert Trie.add(t, [:c]) == %{c: %{}}
    end

    test "add new subtree", context do
        t = Map.get(context, :empty_root)
        assert Trie.add(t, [:c, :c1]) == %{c: %{c1: %{}}}
    end

    test "add to existing subtree", context do
        t = Map.get(context, :simple_tree)
        assert Trie.add(t, [:a, :a2, :a21]) == %{a: %{a1: %{}, a2: %{a21: %{}}}, b: %{}}
    end

    test "delete subtree", context do
        t = Map.get(context, :simple_tree)
        assert Trie.delete(t, [:a]) == %{b: %{}}
    end

    test "search top level", context do
        t = Map.get(context, :simple_tree)
        assert Trie.search(t, [:a]) ==  %{a1: %{}, a2: %{}}
    end

    test "deep search", context do
        t = Map.get(context, :simple_tree)
        t = Trie.add(t, [:a, :a1, :a11])
        assert Trie.search(t, [:a, :a1]) == %{a11: %{}}
    end

    test "no result search", context do
        t = Map.get(context, :simple_tree)
        assert Trie.search(t, [:q]) == %{}
    end
end