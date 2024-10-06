defmodule ElixirToResoniteClient.InstructionCoreTest do
  use ExUnit.Case

  alias ElixirToResoniteClient.InstructionCore

  test "create_field" do
    result = InstructionCore.create_field("1234567890")
    expected = "1234567890          "
    assert result == expected
  end

  test "create_send_data/6" do
    result = InstructionCore.create_send_data([], "move", "Box", "1.0", "1.1", "1.2")

    expected = """
    ["","","resonite:lobby","new_msg",{"body":"move                Box                 1.0                 1.1                 1.2                 "}]
    """

    assert result == [expected]
  end

  test "create_send_data" do
    result = InstructionCore.create_send_data([], "ssss")

    expected = """
    ["","","resonite:lobby","new_msg",{"body":"ssss"}]
    """

    assert result == [expected]
  end

  test "base_data" do
    result = InstructionCore.base_data("phx_join", "")

    expected = """
    ["","","resonite:lobby","phx_join",{}]
    """

    assert result == expected
  end
end
