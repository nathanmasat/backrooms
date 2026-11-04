# THE BACKROOMS: DON'T LOOK BACK — Godot version (Phase 0 + start of Phase 1)

The browser game rebuilt in **Godot 4.7.2**. A game by Nathan.

## Open it
1. Open **Godot** (Steam).
2. In the Project Manager, click **Import**.
3. Pick this folder's **project.godot** file and click **Import & Edit**. Godot spends a moment importing the first time.
4. Press **F5** (or the ▶ Play button at the top right). Click the game window to start.

Controls: **WASD** move · **SHIFT** sprint · **C** crouch · **SPACE** jump · **T** flashlight · **ESC** pause (click to go back in).

## What works so far
- **Level 0, the same maze as the browser game.** The same seed makes exactly the same layout. The browser game's random numbers and Chrome's way of shuffling are copied bit for bit, and `tests/test_maze.gd` checks 8 reference mazes cell by cell (8/8 match).
- Yellow wallpaper, damp carpet, ceiling tiles and glowing panels, painted in code from the browser game's level colours (`data/levels.json`, exported from the browser game, all 20 levels). There's fog, a few flickering panels, and real lights that follow you around (a pool of 10, so it stays fast).
- **The player:** walk 3 m/s, sprint 5.5 m/s with stamina, crouch, jump (about 1.2 m, like the browser game), head bob, and a flashlight with a draining battery.
- HUD: stamina and battery bars, the level name, messages, and a start/pause screen.
- Project setup: Forward+ renderer, Jolt physics, 1920×1080, and the browser game's keys. The always-loaded services are EventBus, Settings, GameState, SaveManager, AudioManager and Net (co-op for up to **6 players** over ENet, not wired into the game yet).

## Folders
`autoload/` game-wide services · `core/` player, random numbers · `levels/` maze, level builder, textures · `ui/` HUD · `data/` exported game data · `tests/` checks · `monsters/` `net/` `story/` `cinematics/` `assets/` (next phases)

## Tests (optional)
- Maze matches the browser: `godot --headless --path . --script res://tests/test_maze.gd`
- Player walks, stops at walls, jumps: `godot --headless --path . res://tests/test_player.tscn`
- Start on a given level and seed: `godot --path . -- --level=0 --seed=12345`

## Next (from the migration plan)
Keycards and the elevator · the Boiled One · co-op host/join (up to 6) · sounds · the browser game's "Export save" button so your progress comes over.
