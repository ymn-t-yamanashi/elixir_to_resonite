defmodule ElixirToResoniteClient do
  @moduledoc """
  Documentation for `ElixirToResoniteClient`.
  """
  alias Socket.Web
  alias ElixirToResoniteClient.InstructionCreation, as: F

  @doc """
  Hello world.

  """
  def hello do
    socket =
      Web.connect!("localhost", 4000, path: "/socket/websocket?token=undefined&vsn=2.0.0")

    F.join()
    |> send_instructions(socket, 10)

    -10..200
    |> Enum.map(fn x ->
      []
      |> F.move("Cylinder", x * 0.1, x * 0.1, 2.0)
      |> F.move("Box", 1.0, 2.0, x * 0.1)
    end)
    |> send_instructions(socket, 10)

    :world
  end

  def send_instructions(instructions, socket, sleep) do
    instructions
    |> Enum.each(fn frame ->
      frame
      |> Enum.each(fn data ->
        Web.send!(socket, {:text, data})
      end)

      Process.sleep(sleep)
    end)
  end
end
