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
    send_frame(frame, socket)

    Process.sleep(timeout)
    send_instructions(instructions, socket, timeout)
  end

  def send_frame([], _socket), do: nil

  def send_frame([frame | frames], socket) do
    Web.send!(socket, {:text, frame})
    send_frame(frames, socket)
  end
end
