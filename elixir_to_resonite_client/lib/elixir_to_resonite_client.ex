defmodule ElixirToResoniteClient do
  @moduledoc """
  Documentation for `ElixirToResoniteClient`.
  """
  alias ElixirToResoniteClient.InstructionCreation, as: F
  alias ElixirToResoniteClient.Socket

  @doc """
  Hello world.

  """
  def hello do
    socket = Socket.connect!()

    F.join()
    |> Socket.send_frame(socket, 0)

    F.init_frame()
    |> F.copy("Box", "TestBo2")
    |> Socket.send_frame(socket, 0)

    -10..200
    |> create_instructions()
    |> Socket.send_instructions(socket, 10)

    F.init_frame()
    |> F.delete("TestBo2")
    |> Socket.send_frame(socket, 0)
  end

  def create_instructions(instruction) do
    instruction
    |> Enum.map(&create_frame(&1))
  end

  defp create_frame(x) do
    F.init_frame()
    |> F.move("Cylinder", x * 0.1, x * 0.1, 2.0)
    |> F.move("Box", 1.0, 2.0, x * 0.1)
  end
end
