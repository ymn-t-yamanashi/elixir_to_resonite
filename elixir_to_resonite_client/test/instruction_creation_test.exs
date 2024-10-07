defmodule ElixirToResoniteClient.InstructionCreationTest do
  use ExUnit.Case

  alias ElixirToResoniteClient.InstructionCreation

  test "move" do
    result = InstructionCreation.move([], "Box", "1.0", "1.1", "1.2")

    expected = """
    ["","","resonite:lobby","new_msg",{"body":"move                Box                 1.0                 1.1                 1.2                 "}]
    """

    assert result == [expected]
  end

  test "copy" do
    result = InstructionCreation.copy([], "Box", "Box2")

    expected = """
    ["","","resonite:lobby","new_msg",{"body":"copy                Box                 Box2                                                        "}]
    """

    assert result == [expected]
  end

  test "delete" do
    result = InstructionCreation.delete([], "Box2")

    expected = """
    ["","","resonite:lobby","new_msg",{"body":"delete              Box2                                                                            "}]
    """

    assert result == [expected]
  end

  test "rotate" do
    result = InstructionCreation.rotate([], "Box", "1.0", "1.1", "1.2")

    expected = """
    ["","","resonite:lobby","new_msg",{"body":"rotate              Box                 1.0                 1.1                 1.2                 "}]
    """

    assert result == [expected]
  end

  test "init_frame" do
    result = InstructionCreation.init_frame()

    expected = []

    assert result == expected
  end

  test "join" do
    result = InstructionCreation.join()

    expected = """
    ["","","resonite:lobby","phx_join",{}]
    """

    assert result == [expected]
  end
end
