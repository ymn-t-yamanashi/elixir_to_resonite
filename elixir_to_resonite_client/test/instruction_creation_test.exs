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

  test "size" do
    result = InstructionCreation.size([], "Box", "1.0", "1.1", "1.2")

    expected = """
    ["","","resonite:lobby","new_msg",{"body":"size                Box                 1.0                 1.1                 1.2                 "}]
    """

    assert result == [expected]
  end

  test "create_object" do
    result = InstructionCreation.create_object([], "F", "T", "1.0", "1.1", "1.2")

    expected1 = """
    ["","","resonite:lobby","new_msg",{"body":"copy                F                   T                                                           "}]
    """

    expected2 = """
    ["","","resonite:lobby","new_msg",{"body":"move                T                   1.0                 1.1                 1.2                 "}]
    """

    assert result == [expected1, expected2]
  end

  test "create_box" do
    result = InstructionCreation.create_box([], "Box1", "1.0", "1.1", "1.2")

    expected1 = """
    ["","","resonite:lobby","new_msg",{"body":"copy                Box                 Box1                                                        "}]
    """

    expected2 = """
    ["","","resonite:lobby","new_msg",{"body":"move                Box1                1.0                 1.1                 1.2                 "}]
    """

    assert result == [expected1, expected2]
  end

  test "create_cylinder" do
    result = InstructionCreation.create_cylinder([], "Cylinder1", "1.0", "1.1", "1.2")

    expected1 = """
    ["","","resonite:lobby","new_msg",{"body":"copy                Cylinder            Cylinder1                                                   "}]
    """

    expected2 = """
    ["","","resonite:lobby","new_msg",{"body":"move                Cylinder1           1.0                 1.1                 1.2                 "}]
    """

    assert result == [expected1, expected2]
  end

  test "create_cone" do
    result = InstructionCreation.create_cone([], "Cone1", "1.0", "1.1", "1.2")

    expected1 = """
    ["","","resonite:lobby","new_msg",{"body":"copy                Cone                Cone1                                                       "}]
    """

    expected2 = """
    ["","","resonite:lobby","new_msg",{"body":"move                Cone1               1.0                 1.1                 1.2                 "}]
    """

    assert result == [expected1, expected2]
  end

  test "create_grid" do
    result = InstructionCreation.create_grid([], "Grid1", "1.0", "1.1", "1.2")

    expected1 = """
    ["","","resonite:lobby","new_msg",{"body":"copy                Grid                Grid1                                                       "}]
    """

    expected2 = """
    ["","","resonite:lobby","new_msg",{"body":"move                Grid1               1.0                 1.1                 1.2                 "}]
    """

    assert result == [expected1, expected2]
  end

  test "create_quad" do
    result = InstructionCreation.create_quad([], "Quad1", "1.0", "1.1", "1.2")

    expected1 = """
    ["","","resonite:lobby","new_msg",{"body":"copy                Quad                Quad1                                                       "}]
    """

    expected2 = """
    ["","","resonite:lobby","new_msg",{"body":"move                Quad1               1.0                 1.1                 1.2                 "}]
    """

    assert result == [expected1, expected2]
  end

  # Sphere
  # Torus
  # Triangle

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
