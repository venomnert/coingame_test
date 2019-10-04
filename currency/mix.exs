defmodule Currency.MixProject do
  use Mix.Project

  def project do
    [
      app: :currency,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Currency.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    []
  end
end
