defmodule Eliver.VersionFile do
  @version_regex ~r/([0-9]+\.[0-9]+\.[0-9]+)/
  @mix_version_regex ~r/version: ([0-9]+\.[0-9]+\.[0-9]+)/

  def version(filename \\ "VERSION") do
    case File.read(filename) do
      {:ok, body} ->
        (Regex.run(@version_regex, body) || []) |> Enum.at(0)

      {:error, _} ->
        nil
    end
  end

  def bump(new_version, filename \\ "VERSION") do
    case File.read(filename) do
      {:ok, body} ->
        new_contents = Regex.replace(@version_regex, body, new_version)

        mix_files()
        |> Enum.each(fn x ->
          rewrite_version(new_version, x)
        end)

        File.write(filename, new_contents)

      {:error, _} ->
        nil
    end
  end

  defp rewrite_version(new_version, filename) do
    case File.read(filename) do
      {:ok, body} ->
        new_contents = Regex.replace(@mix_version_regex, body, "version: #{new_version}")

        File.write(filename, new_contents)

      {:error, _} ->
        nil
    end
  end

  defp mix_files do
    {mixes, _} =
      System.cmd("find", [
        ".",
        "-type",
        "f",
        "-name",
        "mix.exs",
        "-not",
        "-path",
        "./deps/*",
        "-not",
        "-path",
        "./*/**/node_modules/*"
      ])

    mixes |> String.split("\n", trim: true)
  end
end
