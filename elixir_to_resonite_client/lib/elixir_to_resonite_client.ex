defmodule ElixirToResoniteClient do
  @moduledoc """
  Documentation for `ElixirToResoniteClient`.
  """
  alias Socket.Web
  alias ElixirToResoniteClient.InstructionCreation

  @doc """
  Hello world.

  """
  def hello do
    socket =
      Web.connect!("localhost", 4000, path: "/socket/websocket?token=undefined&vsn=2.0.0")

    InstructionCreation.join()
    |> send_instructions(socket, 250)

    [
      ["Box", "1.0", "2.0", "1.0"],
      ["Cylinder", "1.0", "2.0", "2.0"],
      ["Box", "1.0", "3.0", "1"],
      ["Box", "1.0", "4.0", "1"],
      ["Box", "1.0", "5.0", "1"],
      ["Cylinder", "1.0", "2.0", "3"],
      ["Cylinder", "1.0", "2.0", "4"],
      ["Cylinder", "1.0", "2.0", "5"]
    ]
    |> Enum.each(fn data -> frame(data, socket) end)

    :world
  end

  defp frame([m, x, y, z], socket) do
    []
    |> InstructionCreation.move(m, x, y, z)
    |> send_instructions(socket, 250)
  end

  def send_instructions(instructions, socket, sleep) do
    instructions
    |> Enum.each(fn data ->
      Web.send!(socket, {:text, data})
    end)

    Process.sleep(sleep)
  end
end
