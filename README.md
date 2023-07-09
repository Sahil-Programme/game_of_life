# GAME OF LIFE
This is a simple implementation of Conway's Game of Life using the Flutter framework. The Game of Life is a cellular automaton devised by the mathematician John Conway in 1970. It consists of a grid of cells, each of which can be in one of two states: alive or dead. The game follows a set of rules that determine the state of each cell in the next generation based on its current state and the states of its neighboring cells.

## Features
* Interactive grid: The game provides an interactive grid where you can toggle the state of each cell by tapping on it.
* Step simulation: You can step through the generations of the game by tapping the "Step" button, which calculates the next generation based on the current grid state.
* Auto simulation: You can enable auto simulation mode, which automatically calculates and displays the next generation at a regular interval.
* Randomize grid: The game allows you to randomize the initial state of the grid by tapping the "Randomize" button.
* Clear grid: You can reset the grid to an empty state by tapping the "Clear" button.

## Getting Started
To run the Game of Life, ensure that you have Flutter and its dependencies installed on your development environment. You can find detailed instructions on how to set up Flutter in the official Flutter documentation.

Clone this repository or download the source code.

bash
Copy code
git clone https://github.com/your-username/game-of-life.git
Navigate to the project directory.

bash
Copy code
cd game-of-life
Fetch the dependencies.

arduino
Copy code
flutter pub get
Connect your Android or iOS device to your computer or set up an emulator.

Run the application.

arduino
Copy code
flutter run
How to Play
On the main screen, you will see a grid of cells. Tap on any cell to toggle its state between alive and dead.

Use the control buttons at the bottom of the screen to interact with the game:

Step: Calculates and displays the next generation of the game based on the current grid state.
Auto: Enables or disables auto simulation mode. In auto simulation mode, the game automatically calculates and displays the next generation at a regular interval.
Randomize: Randomizes the initial state of the grid, turning some cells alive and others dead.
Clear: Resets the grid to an empty state, making all cells dead.
Enjoy experimenting with different patterns and observing the emergent behavior of the game!

Customization
If you want to customize the behavior or appearance of the Game of Life, you can modify the source code. Here are some possible customizations:

* Change the size of the grid: You can adjust the number of rows and columns in the grid by modifying the rows and columns variables in the main.dart file.
* Customize the UI: You can modify the layout, colors, and styles of the user interface by editing the corresponding Flutter widgets in the main.dart file.

## Acknowledgments
This implementation of the Game of Life was created by Sahil Yadav as a personal project.
The Game of Life concept was devised by John Conway in 1970 and has been widely studied and explored by many researchers and enthusiasts.
License
This project is licensed under the MIT License. Feel free to modify and distribute the code as per the terms of the license.