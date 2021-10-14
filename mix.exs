defmodule Ocr.MixProject do
  use Mix.Project

  def project do
    [
      app: :ocr,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:word_finder],
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dep_from_hexpm, "~> 0.3.0"},
      {:secure_random, "~> 0.5.1"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:tesseract_ocr, "~> 0.1.5"},
      {:word_finder, "~> 0.1.0"},
      {:hackney, "~> 1.15"}
    ]
  end
end
