defmodule TextClient.Player do
  alias TextClient.{Mover, Prompter, State, Summary}

  def play(%State{game_service: %{letters: letters}, tally: %{game_state: :won}}) do
    exit_with_message("A winner is you!", letters)
  end

  def play(%State{game_service: %{letters: letters}, tally: %{game_state: :lost}}) do
    exit_with_message("Sorry, you lost", letters)
  end

  def play(game = %State{tally: %{game_state: :good_guess}}) do
    continue_with_message(game, "Good guess!")
  end

  def play(game = %State{tally: %{game_state: :bad_guess}}) do
    continue_with_message(game, "Sorry that isn't in the word")
  end

  def play(game = %State{tally: %{game_state: :already_used}}) do
    continue_with_message(game, "You've already used that letter...")
  end

  def play(game) do
    continue(game)
  end

  def continue_with_message(game, message) do
    IO.puts(message)
    continue(game)
  end

  def continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  def display(game) do
    game
  end

  def prompt(game) do
    game
  end

  def make_move(game) do
    game
  end

  defp exit_with_message(msg, word) do
    IO.puts(msg)
    IO.puts(["The correct word was: ", word])
    exit(:normal)
  end
end
