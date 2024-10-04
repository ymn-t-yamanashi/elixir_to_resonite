defmodule MidiToResonite do
  alias ElixirToResoniteClient.InstructionCreation, as: F
  alias ElixirToResoniteClient.Socket

  @moduledoc """
  Documentation for `MidiToResonite`.
  """

  @doc """
  Hello world.
  """
  def hello do
    socket = Socket.connect!()

    F.join()
    |> Socket.send_frame(socket, 0)

    F.init_frame()
    |> F.move("Box", 1, 1, 2)
    |> Socket.send_frame(socket, 10)

    :world
  end
end
