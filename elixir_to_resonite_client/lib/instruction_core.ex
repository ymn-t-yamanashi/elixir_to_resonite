defmodule ElixirToResoniteClient.InstructionCore do
  @moduledoc """
  This module assembles instructions to communicate with a Resonite environment.
  """

  @doc """
  Initialize the animation to the first frame
  """
  def init_frame(), do: []

  @doc """
  Create a field
  """
  def create_field(value) do
    (value <> String.duplicate(" ", 20))
    |> String.slice(0, 20)
  end

  @doc """
  Create a send data
  """
  def create_send_data(send_datas, instruction, name, argument1, argument2, argument3) do
    [instruction, name, argument1, argument2, argument3]
    |> Enum.map(&create_field(&1))
    |> List.to_string()
    |> then(&create_send_data(send_datas, &1))
  end

  def create_send_data(send_datas, data) do
    data = base_data("new_msg", "\"body\":\"#{data}\"")

    send_datas ++ [data]
  end

  @doc """
  Creating a base data structure for WebSocket communication
  """
  def base_data(instruction, data) do
    """
    ["","","resonite:lobby","#{instruction}",{#{data}}]
    """
  end
end
