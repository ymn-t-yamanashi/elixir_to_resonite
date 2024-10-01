defmodule ElixirToResoniteClient.InstructionCreationTest do
  use ExUnit.Case

  test "move" do
    result = ElixirToResoniteClient.InstructionCreation.move([], "Box", "1.0", "1.1", "1.2")

    expected = """
    ["3","4","resonite:lobby","new_msg",{"body":"move                Box                 1.0                 1.1                 1.2                 "}]
    """

    assert result == [expected]
  end

  test "create_field" do
    result = ElixirToResoniteClient.InstructionCreation.create_field("1234567890")
    expected = "1234567890          "
    assert result == expected
  end

  test "send_data" do
    result = ElixirToResoniteClient.InstructionCreation.send_data([], "ssss")

    expected = """
    ["3","4","resonite:lobby","new_msg",{"body":"ssss"}]
    """

    assert result == [expected]
  end

  test "join" do
    result = ElixirToResoniteClient.InstructionCreation.join()

    expected = """
    ["3","3","resonite:lobby","phx_join",{}]
    """

    assert result == [[expected]]
  end
end
