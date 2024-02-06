Gameplay:
- Tap to start the game or make the bird jump.
- Navigate the bird through barriers by tapping.
- Score points for each successfully passed barrier.
- Game over if the bird hits the top/bottom or collides with barriers.
  
Code Structure:

main.dart
- Entry point of the app.
- Initializes Phoenix for hot-reloading.
- Launches the MyApp widget.
  
homepage.dart
- Implements the main game logic and UI.
- Uses animations for bird movement and barrier scrolling.
- Manages game states, scoring, and game-over conditions.
  
barriers.dart
- Defines the MyBarrier widget for creating obstacles.
- Uses simple green rectangles with borders.
  
Game Logic:
- Bird movement controlled by physics equations.
- Barriers move from right to left, and new ones appear as old ones pass.
- Game-over conditions check for collisions with barriers and screen boundaries.
- Score is incremented for each passed barrier.
  
User Interface:
- Divided into two parts: gameplay screen and score display.
- Tapping actions trigger game start, jumping, or game restart.
  
Restarting the Game:
- Game restarts using the Phoenix package.
- Best score is updated if a new high score is achieved.
