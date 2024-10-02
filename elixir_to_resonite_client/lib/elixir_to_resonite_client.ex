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
    |> F.create_instructions()
    |> Socket.send_instructions(socket, 10)

    -10..200
    |> Enum.map(fn x ->
      F.init_frame()
      |> F.move("Cylinder", x * 0.1, x * 0.1, 2.0)
      |> F.move("Box", 1.0, 2.0, x * 0.1)
    end)
    |> Socket.send_instructions(socket, 10)

    F.init_frame()
    |> F.delete("TestBo2")
    |> F.create_instructions()
    |> Socket.send_instructions(socket, 10)
  end
end
