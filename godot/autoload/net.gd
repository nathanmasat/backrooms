extends Node
## Co-op multiplayer (up to 6 players). Phase 1: host / join on a local network with ENet.
## The host runs the monsters; everyone shares the level seed.

const PORT := 24680
const MAX_PLAYERS := 6

signal joined(id: int)
signal left(id: int)


func host() -> Error:
	var peer := ENetMultiplayerPeer.new()
	var err := peer.create_server(PORT, MAX_PLAYERS - 1)
	if err == OK:
		multiplayer.multiplayer_peer = peer
		multiplayer.peer_connected.connect(func(id): joined.emit(id))
		multiplayer.peer_disconnected.connect(func(id): left.emit(id))
	return err


func join(address: String) -> Error:
	var peer := ENetMultiplayerPeer.new()
	var err := peer.create_client(address, PORT)
	if err == OK:
		multiplayer.multiplayer_peer = peer
	return err


func is_online() -> bool:
	return multiplayer.multiplayer_peer != null and not (multiplayer.multiplayer_peer is OfflineMultiplayerPeer)
