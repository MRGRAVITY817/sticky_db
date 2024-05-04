defmodule StickyDB.MixProject do
  use Mix.Project

  @version "0.0.1"
  @repo_url "https://github.com/MRGRAVITY817/sticky_db"

  def project do
    [
      app: :sticky_db,
      version: @version,
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      description: "Ecto adapters for GlueSQL Elixir library - It's very sticky!",
      package: package()
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
      {:ecto_sql, "~> 3.0"},
      {:rustler, "~> 0.29.0"},
      {:jason, "~> 1.4.1"},
      {:ex_doc, "~> 0.31", only: :dev, runtime: false},
      {:earmark, "~> 1.4", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      main: "StickyDB",
      extras: ["CHANGELOG.md"],
      skip_undefined_reference_warnings_on: ["CHANGELOG.md"],
      source_ref: "v#{@version}",
      source_url: @repo_url
    ]
  end

  defp package do
    [
      files: [
        "lib",
        "mix.exs",
        "README.md",
        "CHANGELOG.md",
        "LICENSE",
        "native"
      ],
      maintainers: ["Hoon Wee"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @repo_url}
    ]
  end
end
