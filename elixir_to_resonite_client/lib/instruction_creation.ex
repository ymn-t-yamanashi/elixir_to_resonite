defmodule ElixirToResoniteClient.InstructionCreation do
  def move(send_datas, name, x, y, z) do
    send_data(send_datas, "move", name, "#{x}", "#{y}", "#{z}")
  end

  def copy(send_datas, name, to_name) do
    send_data(send_datas, "copy", name, to_name, "", "")
  end

  def delete(send_datas, name) do
    send_data(send_datas, "delete", name, "", "", "")
  end

  def init_frame(), do: []
  def create_instructions(instruction), do: [instruction]

  def create_field(value) do
    (value <> String.duplicate(" ", 20))
    |> String.slice(0, 20)
  end

  def send_data(send_datas, instruction, name, argument1, argument2, argument3) do
    [instruction, name, argument1, argument2, argument3]
    |> Enum.map(&create_field(&1))
    |> List.to_string()
    |> then(&send_data(send_datas, &1))
  end

  def send_data(send_datas, data) do
    data = base_data("new_msg", "\"body\":\"#{data}\"")

    send_datas ++ [data]
  end

  def join() do
    phx_join = base_data("phx_join", "")
    [[phx_join]]
  end

  def base_data(instruction, data) do
    """
    ["","","resonite:lobby","#{instruction}",{#{data}}]
    """
  end
end
