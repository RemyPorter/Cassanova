defmodule Trie do
    require Access
    def add(root, [item | []]) do
        case root do
            %{^item => _} -> root
            _ -> Map.put_new(root, item, %{})
        end
    end

    def add(root, []) do
        root
    end

    def add(root, [item|items]) do
        base = case root do
            %{^item => m} -> m
            _ -> %{}
        end
        Map.put(root, item, add(base, items))
    end

    def search(root, [item | []]) do
        case root do
            %{^item => val} -> val
            _ -> %{}
        end
    end

    def search(root, [item | items]) do
        case root do
            %{^item => val} -> search(val, items)
            _ -> %{}
        end
    end

    def delete(root, [item | []]) do
        Map.delete(root, item)
    end

    def delete(root, [item | items]) do
        deleted = delete(root[item], items)
        Map.put(root, item, deleted)
    end
end