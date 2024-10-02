defmodule Sample.SampleTest do
  use ExUnit.Case

  test "Run Sample.Sample" do
    System.get_env("TEST")
    |> sample()
  end

  def sample("1"), do: Sample.Sample1.run()
  def sample(_), do: nil
end
