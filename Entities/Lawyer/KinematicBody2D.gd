extends KinematicBody2D


onready var id = self.get_parent().id
onready var sprite = $AnimatedSprite
var alive : bool
var gravity : int = 400
var speed = 228
var velocity : Vector2
const jump : int = 310
var grounded : bool = false

func _ready():
	alive = true
	sprite.animation = "default"

func _physics_process(delta):
	speed += gravity*delta
	velocity = Vector2(0, speed)
	var collision_info = move_and_collide(velocity*delta)
	if collision_info:
		self.get_parent().emit_signal("collided", collision_info, id)
		sprite.animation = "default"
		grounded = true
		speed = 228
	else: grounded = false

func _input(event):
	if event.is_action_pressed("jump_" + str(id)) and grounded:
		speed = -jump
		sprite.animation = "jump"
	if event.is_action_released("jump_" + str(id)):
		speed = 228
		
func kill():
	if alive:
		$Tween.interpolate_property(sprite, "modulate", Color(1, 1, 1, 1), 
		Color(0, 0, 0, 0), 1, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
		$Tween.start()
		alive = false
		get_parent().emit_signal("dead", id)
