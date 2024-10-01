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

    -100..100
    |> Enum.map(fn x ->
      []
      |> InstructionCreation.move("Cylinder", "#{x * 0.1}", "1.0", "2.0")
      |> InstructionCreation.move("Box", "1.0", "2.0", "#{x * 0.1}")
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
