defmodule AOC2021.MixProject do
  use Mix.Project

  def project do
    [
      app: :aoc_2021,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_paths: ["lib"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:matrix, "~> 0.3"},
      {:mix_test_watch, "~> 1.1.0", only: :dev, runtime: false},
      {:priority_queue, "~> 1.0.0"}
    ]
  end
end
