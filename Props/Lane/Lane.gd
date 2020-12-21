extends Node2D

onready var tiles = $TileMap
const ll : int = 20           #lane length
var cur_lane : Array
var cur_cell : int = 0
var tile_queue : Array = [0, 1, 1, 0]
export var difficulty : int = 1
const player_tile : Vector2 = Vector2(2, 0)
signal killed(id)

func _ready():
	randomize()
	for _i in range(ll):
		cur_lane.append(0)
	var i = 0
	for cell in cur_lane:
		tiles.set_cell(i, 0, cell)
		i += 1

func _process(_delta):
	if cur_cell != ll-1:
		cur_lane[cur_cell] = cur_lane[cur_cell+1]
	else:
		cur_lane[cur_cell] = tile_pop()
	tiles.set_cell(cur_cell, 0, cur_lane[cur_cell])
	if cur_cell != ll-1:
		cur_cell+=1
	else:
		cur_cell = 0

func make_tiles():
	var r
	if difficulty == 0: r = 0
	else: r = randi()%10+1
	var slice
	match r:
		1:
			if difficulty == 1: slice = [0, 1, 0, 1, 0, 0, 1, 1, 1, 0]
			if difficulty == 2: slice = [0, 1, 0, 1, 0, 0, 0, 0, 1, 0]
			if difficulty == 3: slice = [0, 0, 0, 1, 1, 1, 0, 0, 0, 0]
		2:
			if difficulty == 1: slice = [0, 1, 0, 1, 0, 1, 1, 0, 0, 1]
			if difficulty == 2: slice = [0, 1, 0, 1, 0, 0, 1, 0, 0, 1]
			if difficulty == 3: slice = [0, 0, 1, 0, 0, 0, 0, 1, 0, 0]
		3:
			if difficulty == 1: slice = [1, 0, 1, 1, 1, 0, 0, 1, 1, 0]
			if difficulty == 2: slice = [0, 0, 1, 0, 1, 0, 0, 1, 0, 0]
			if difficulty == 3: slice = [1, 0, 0, 0, 1, 1, 0, 0, 0, 0]
		4:
			if difficulty == 1: slice = [0, 1, 0, 0, 0, 1, 0, 1, 0, 1]
			if difficulty == 2: slice = [0, 1, 0, 0, 0, 0, 1, 0, 1, 0]
			if difficulty == 3: slice = [0, 1, 0, 1, 0, 0, 0, 0, 0, 0]
		5:
			if difficulty == 1: slice = [1, 0, 0, 1, 1, 1, 0, 0, 1, 0]
			if difficulty == 2: slice = [1, 0, 0, 0, 1, 1, 0, 0, 1, 0]
			if difficulty == 3: slice = [0, 0, 0, 0, 1, 1, 1, 0, 0, 0]
		6:
			if difficulty == 1: slice = [0, 0, 1, 1, 0, 1, 0, 1, 1, 0]
			if difficulty == 2: slice = [0, 0, 1, 0, 0, 1, 0, 1, 0, 0]
			if difficulty == 3: slice = [0, 0, 1, 1, 0, 0, 1, 1, 0, 0]
		7:
			if difficulty == 1: slice = [1, 0, 1, 0, 1, 0, 1, 1, 0, 0]
			if difficulty == 2: slice = [1, 0, 1, 0, 1, 0, 0, 0, 0, 0]
			if difficulty == 3: slice = [1, 0, 0, 0, 0, 0, 0, 1, 0, 1]
		8:
			if difficulty == 1: slice = [0, 1, 1, 1, 0, 1, 1, 1, 0, 1]
			if difficulty == 2: slice = [0, 1, 1, 0, 0, 1, 1, 0, 0, 1]
			if difficulty == 3: slice = [0, 0, 0, 0, 0, 1, 0, 1, 0, 1]
		9:
			if difficulty == 1: slice = [1, 1, 0, 1, 0, 0, 0, 1, 1, 0]
			if difficulty == 2: slice = [1, 1, 0, 0, 0, 1, 0, 0, 1, 0]
			if difficulty == 3: slice = [0, 0, 0, 0, 1, 0, 0, 0, 0, 0]
		10:
			if difficulty == 1: slice = [0, 0, 1, 1, 0, 1, 1, 1, 0, 0]
			if difficulty == 2: slice = [0, 1, 0, 1, 0, 0, 1, 1, 1, 0]
			if difficulty == 3: slice = [0, 0, 0, 0, 1, 0, 1, 0, 1, 0]
		_:
			slice = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	return slice

func tile_pop():
	var tile
	if tile_queue.size() < 3:
		for _i in range(randi()%3+2):
			tile_queue.append(0)
	elif tile_queue.size() > 20:
		pass
	else:
		var new_tiles = make_tiles()
		for t in new_tiles:
			tile_queue.append(t)
			
	tile = tile_queue.pop_front()
	return tile

func _on_Lawyer_collided(collision, id):
	if collision.collider is TileMap:
		if tiles.get_cellv(player_tile) == 1:
			emit_signal("killed", id)

func change_difficulty(d):
	self.difficulty = d



