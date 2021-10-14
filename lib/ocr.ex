defmodule Ocr do
  alias Ocr
  alias Ocr.Fiscal

  @moduledoc """
  Documentation for `Ocr`.
  """

  @doc """
  Ler todos os arquivos que estão em um diretório.

  ## Examples

      iex> Ocr.ReadFileDirectory()
      :namefile

  """

  @params_dir_in "img_in"
  @params_dir_out "csv_out"

  def generate_img_csv do
    read_image_file_out(@params_dir_in)
    out_files = File.ls!(@params_dir_out)

    captura_line("#{@params_dir_out}/#{out_files}")
    Fiscal.create_csv_and_delete_txt("#{@params_dir_out}/#{out_files}")
  end

  def read_file_directory(dir) do
    dir
    |> File.ls!()
    |> Enum.map(fn x -> "#{dir}/#{x}" end)
  end

  def change_filename_txt(filename) do
    filename
    |> String.replace(Path.extname(filename), ".txt")
    |> String.replace(@params_dir_in, @params_dir_out)
  end

  def read_image_file_out(dir) do
    dir
    |> read_file_directory()
    |> Enum.map(fn x ->
      File.write!(change_filename_txt(x), TesseractOcr.read(x))
    end)
  end

  def captura_line(out) do
    File.stream!(out)
    |> Stream.map(&String.strip/1)
    |> Stream.with_index()
    |> Stream.map(fn {line, index} -> line(line) end)
    |> Stream.run()


  end

  defp line(l) do
    list = ["TOTAL", "UNF", "T06", "TUN", "1UNF", "TUF", "1UNI", "T03", "103", "/"]

    Enum.map(list, fn x ->
      if String.contains?(l, x) do
        map = l
      end
    end)

    if String.contains?(l, "PRE FRANCES") do
      v = String.replace(l, "PRE", "PÃO")
    end

    if String.contains?(l, "QS CRAPUS") do
      v =
        String.replace(
          l,
          "QS ",
          "RUA CAMPOS ",
          global: true
        )
    end

    if String.contains?(l, "TLOS E") do
      v =
        String.replace(
          l,
          "TLOS ",
          "SILVA ",
          global: true
        )
    end

    if String.contains?(l, "COP S68 ABT 6A2/01S-36") do
      v =
        String.replace(
          l,
          "COP S68 ABT 6A2/01S-36",
          "CNPJ: 60.437.647/0019 ",
          global: true
        )
    end
  end
end
