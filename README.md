# Knight's Travails
## About
* This is a program that allows the user to find the shortest path a knight can take from one square to another on a chess board.

## How to use
* `#knight_moves` takes two arrays as arguments, as follows: `#knight_moves([0, 0], [3, 3])`.
* Each array represents a square on a chess board.
* The first number in an array indicates the file of that square.
* The second number in an array indicates the rank of that square.
* As such, *[0, 0]* represents square *A1*, and *[7, 7]* represents square *H8*.
* `#knight_moves` will display all the squares visited in the shortest path from the start square to the end square.