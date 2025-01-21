# Enhanced Tic-Tac-Toe Game

## Introduction

This project is an advanced implementation of the classic Tic-Tac-Toe game with additional features for human vs. human and human vs. machine gameplay. It is written in **x68 assembly language**, focusing on efficient memory usage and logic. The project contains routines for drawing, input validation, and game mechanics to simulate a grid-based game with a refined user interface.

---

## Features

- **Game Modes:**
  - Human vs. Human
  - Human vs. Machine

- **Drawing Routines:**
  - Grid rendering using `SHOW_GRILL`.
  - Symbol rendering for X and O using `DRAWX` and `DRAW_ELLIPSE`.

- **Game Logic:**
  - Valid input checking.
  - Automatic machine move selection.
  - Detection of game outcomes (win, draw).

- **Performance:**
  - Optimized routines for efficient handling of grid coordinates and checks.

---

## Files and Modules

### Core Assembly Files:

- **`BIBGRAPH.x68`:**
  - Contains routines for drawing lines and ellipses on the game grid.
  - Implements grid rendering and graphical updates.

- **`BIBLIO_MACHINE.x68`:**
  - Provides input/output routines for interaction.
  - Includes utility functions like cursor positioning, string display, and input validation.

- **`BIBLIO.x68`:**
  - A shared library for basic I/O operations.
  - Functions for displaying strings, cursor positioning, and newline rendering.

### Game Logic:

- **`GAME_HUMAIN.x68`:**
  - Implements the human vs. human game mode.
  - Manages turn-taking, input validation, and win conditions.

- **`MACHINE.x68`:**
  - Implements the human vs. machine game mode.
  - The machine intelligently selects moves.

---

## How to Run

1. **Setup:**
   - Ensure all `.x68` files are compiled and linked appropriately for your assembly environment.

2. **Execution:**
   - Run the appropriate game mode file (`GAME_HUMAIN.x68` or `MACHINE.x68`) using your assembly program loader.

3. **Gameplay:**
   - Follow on-screen instructions to select grid positions.
   - The game will display outcomes, including wins or draws.

---

## Key Functions

### Drawing
- **`SHOW_GRILL`:** Renders the game grid.
- **`DRAWX`:** Draws an X symbol on the grid.
- **`DRAW_ELLIPSE`:** Draws an O symbol on the grid.

### Input Validation
- **`CHECK_VALID_INPUT`:** Ensures valid player inputs for pattern selection and grid position.
- **`CALCULEK`:** Calculates memory offsets for grid positions.

### Game Mechanics
- **`CHECK_WIN_LINE`:** Checks for winning conditions along rows.
- **`CHECK_WIN_COL`:** Checks for winning conditions along columns.
- **`CHECK_WIN_DIAG1` and `CHECK_WIN_DIAG2`:** Check diagonal win conditions.

---

## Gameplay

1. **Choose a Mode:**
   - Human vs. Human: Both players take turns.
   - Human vs. Machine: Player competes against the machine.

2. **Make Moves:**
   - Players choose grid positions by entering row and column numbers.
   - Machine selects moves automatically in its turn.

3. **Win or Draw:**
   - The game announces the winner or a draw when no valid moves remain.

---

## Future Improvements

- Add support for custom grid sizes.
- Implement difficulty levels for the machine player.
- Enhance visuals with advanced drawing techniques.
