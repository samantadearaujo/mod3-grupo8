defmodule Ocr.Fiscal do
  defstruct [:company, :adress, :docs, :phone, :items, :date, :total]

  def create_csv_and_delete_txt(filename) do
    file = filename |> String.replace(Path.extname(filename), ".csv")
    dir = filename |> String.replace("csv_out/", "")
    File.cp!("temp/out/#{String.replace(dir, Path.extname(filename), ".csv")}", "#{file}")
    File.rm(filename)

    IO.puts("DONE!!!")
  end

end
