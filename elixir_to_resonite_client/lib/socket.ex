defmodule ElixirToResoniteClient.Socket do
  @moduledoc """
  """
  alias Socket.Web

  def connect!() do
    Web.connect!("localhost", 4000, path: "/socket/websocket?token=undefined&vsn=2.0.0")
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
