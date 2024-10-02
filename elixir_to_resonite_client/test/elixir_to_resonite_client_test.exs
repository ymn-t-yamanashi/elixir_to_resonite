defmodule ElixirToResoniteClientTest do
  use ExUnit.Case

  test "greets the world" do
    if System.get_env("TEST") == "OK" do
        ElixirToResoniteClient.hello()
    end
  end
end
