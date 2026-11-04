extends Node
## Game-wide signals, so systems can talk without knowing about each other.

signal level_started(level: int, seed_value: int)
signal player_died(cause: String)
signal item_picked(kind: String, position: Vector3)
signal message(text: String, seconds: float)
