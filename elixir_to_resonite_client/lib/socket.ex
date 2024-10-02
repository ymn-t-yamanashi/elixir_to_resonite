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
  def send_instructions([], _socket, _timeout), do: nil
  def send_instructions([frame | instructions], socket, timeout) do
    frame
    |> Enum.each(fn data ->
      Web.send!(socket, {:text, data})
    end)

    Process.sleep(timeout)
    send_instructions(instructions, socket, timeout)
  end
end
