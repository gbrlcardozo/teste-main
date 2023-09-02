defmodule SheetOpsEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :sheet_ops_ex,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript(),
      preferred_cli_env: [
        "test.watch": :test
      ],
      elixirc_paths:
        case Mix.env() do
          :test -> ["lib", "test"]
          _ -> ["lib"]
        end
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp escript do
    [main_module: SheetOpsEx]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.4.0"},
      {:mix_test_watch, "~> 1.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false}
    ]
  end
end
