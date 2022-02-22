import std.stdio;
import std.string;
import std.conv;
import std.random;

string format_slot(int value) {
	switch(value) {
		case 1: return " X ";
		case 2: return " O ";
		default: return "   ";
	}
}

class GameBoard {
	int[9] board;

	this(int[9] board = [0, 0, 0, 0, 0, 0, 0, 0, 0]) {
		this.board = board;
	}

	string format() {
		return (format_slot(board[0]) ~ "|" ~ format_slot(board[1]) ~ "|" ~ format_slot(board[2])
				~ "\n---+---+---\n" ~
				format_slot(board[3]) ~ "|" ~ format_slot(board[4]) ~ "|" ~ format_slot(board[5])
				~ "\n---+---+---\n" ~
				format_slot(board[6]) ~ "|" ~ format_slot(board[7]) ~ "|" ~ format_slot(board[8]));
	}
}

void main() {
	GameBoard game_board = new GameBoard();
	while(true) {
		// Show data to player
		writeln(game_board.format());
		writeln("Type the number of the place you want to place...");

		// Wait for input
		string input = readln();
		// Remove the \n at the end
		input = input[0..input.length - 1];
		// Convert to int
		size_t index = to!size_t(input) - 1;

		// Make sure that the index is valid (in range) and that there isn't already a mark there
		if (index >= 0 && index < 9 && game_board.board[index] == 0) {
			game_board.board[index] = 1;

			if (check_winner(game_board)) {
				return;
			}

			// Do AI move
			size_t ai_choice = 0;
			while (game_board.board[ai_choice] != 0) {
				ai_choice = uniform(0, 9);
			}
			game_board.board[ai_choice] = 2;

			// I'm checking the winner twice because I have to check the after the player moves and after the AI moves
			if (check_winner(game_board)) {
				return;
			}
		}
	}
}

bool check_winner(GameBoard game_board) {
	for (size_t x_off = 0; x_off < 3; x_off++) {
		// Check the horizontal rows
		if (game_board.board[0 + x_off * 3] != 0
		&& game_board.board[0 + x_off * 3] == game_board.board[1 + x_off * 3]
		&& game_board.board[1 + x_off * 3] ==  game_board.board[2 + x_off * 3]) {
			switch (game_board.board[0 + x_off * 3]) {
				case 1:
					writeln("Player wins!");
					break;
				case 2:
					writeln("AI wins!");
					break;
				default:
					break;
			}
			return true;
		}

		// Check the vertical rows
		if (game_board.board[0 + x_off] != 0
		&& game_board.board[0 + x_off] == game_board.board[3 + x_off]
		&& game_board.board[3 + x_off] ==  game_board.board[6 + x_off]) {
			switch (game_board.board[0 + x_off]) {
				case 1:
					writeln("Player wins!");
					break;
				case 2:
					writeln("AI wins!");
					break;
				default:
					break;
			}
			return true;
		}

		// Check the diagonals
		if (game_board.board[0] != 0
		&& game_board.board[0] == game_board.board[4]
		&& game_board.board[4] == game_board.board[8]) {
			switch (game_board.board[0]) {
				case 1:
					writeln("Player wins!");
					break;
				case 2:
					writeln("AI wins!");
					break;
				default:
					break;
			}
			return true;
		}

		if (game_board.board[2] != 0
		&& game_board.board[2] == game_board.board[4]
		&& game_board.board[4] == game_board.board[6]) {
			switch (game_board.board[2]) {
				case 1:
					writeln("Player wins!");
					break;
				case 2:
					writeln("AI wins!");
					break;
				default:
					break;
			}
			return true;
		}
	}
	return false;
}