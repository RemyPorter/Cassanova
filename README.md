# Cassanova

Cassanova (csv for short), is a big-data, distributed architecture database… that uses CSV for all of its inputs and outputs. It has no types, it has no schemas, it has no structure. This is a restart of the [CSVBase](https://github.com/RemyPorter/CSVDB) project (which was originally implemented in Python). Elixir and Erlang's process model is a better fit for building applications that scale in a distributed fashion, and that is, after all, our goal.

Why? Because of Remy's Law of Requirements Gathering: No matter what your users said, what they really want is for you to reinvent Excel.

Let's stop reinventing Excel, by making an Excel-friendly database that's suitable for Big Data applications.

**NB**: Yes, this is in fact a joke. A joke that's going to go waaaaaayyyy to far, but I'm still gonna do it.

**NB**: Also, I don't know Elixir. I'm using this project to learn it.
<!--

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `cassanova` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:cassanova, "~> 0.1.0"}]
    end
    ```

  2. Ensure `cassanova` is started before your application:

    ```elixir
    def application do
      [applications: [:cassanova]]
    end
    ```-->

