defmodule SheetOpsExTest do
  use ExUnit.Case
  doctest SheetOpsEx

  def check(current, target) do
    {:ok, mock} = GoogleSheetsApiMock.Server.new()
    GoogleSheetsApiMock.Server.add_spreadsheet(mock, "abc", current)
    SheetOpsEx.update_spreadsheet(mock, "abc", current, target)
    {:ok, final} = GoogleSheetsApiMock.Server.fetch_spreadsheet_state(mock, "abc")

    assert target == final
  end

  test "empty" do
    check(%{columns: [], rows: []}, %{columns: [], rows: []})
  end

  test "nils" do
    check(
      %{columns: [nil, nil, nil], rows: [nil, nil, nil]},
      %{columns: [nil, nil, nil], rows: [nil, nil, nil]}
    )
  end

  test "example 1" do
    check(
      %{
        columns: [14, nil, nil, nil, 12, 7, 4, 13, 6, nil],
        rows: [15, 14, 13, nil, 8, 11, nil, 7, 12, 2, nil, nil, 9]
      },
      %{
        columns: [nil, nil, 11, 14, nil, 4, nil, 9, 13, 5, 7, 3],
        rows: [9, 12, 3, 13, nil, nil, 4, 8, 5, nil, 6, nil, 10]
      }
    )
  end

  test "example 2" do
    check(
      %{
        columns: [8, 7, 15, nil, 11, 13, 2],
        rows: [nil, 2, 6, 7, 8, 1, 5]
      },
      %{
        columns: [4, 5, nil, 2, 6, 1, 8, 7],
        rows: [8, 6, 5, 7, 4, nil, 1]
      }
    )
  end

  test "large sheet" do
    current = Jason.decode!(File.read!("test/data/large_current.json"), keys: :atoms)
    target = Jason.decode!(File.read!("test/data/large_target.json"), keys: :atoms)
    check(current, target)
  end
end
