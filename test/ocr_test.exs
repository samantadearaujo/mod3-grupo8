defmodule OcrTest do
  use ExUnit.Case
  doctest Ocr

  test "greets the world" do
    assert Ocr.hello() == :world
  end
end
