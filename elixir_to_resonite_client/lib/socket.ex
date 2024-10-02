defmodule ElixirToResoniteClient.Socket do
  @moduledoc """
  """
  alias Socket.Web

  @doc """
  Connecting via WebSocket
  """
  def connect!() do
    Web.connect!("localhost", 4000, path: "/socket/websocket?token=undefined&vsn=2.0.0")
  end

  @doc """
  Send instructions using WebSocket
  """
  def send_instructions(instructions, socket, timeout) do
    instructions
    |> Enum.each(fn frame ->
      frame
      |> Enum.each(fn data ->
        Web.send!(socket, {:text, data})
      end)

      Process.sleep(timeout)
    end)
  end
end
