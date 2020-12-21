extends Node2D

var lawyers : Array = [true, true, true]
var law_num : int = 3
var score : int = 0
var time_acc : float = 0
var running : bool = false

func _ready():
	running = true
	$Label.text = str(score)

func _process(delta):
	time_acc += delta
	if time_acc > 1 and running:
		score += law_num
		time_acc = 0
		$Label.text = str(score)
	if law_num == 0:
		running = false
		law_num = -1
		$Timer.start()

func end_game():
	for object in get_children():
		if object.is_in_group("screen"):
			object.visible = false
	$God/Final.text = "Well, you have defended " + str(score) + " souls. I declare this court adjourned..."
	$God.visible = true


func _on_Lawyer_dead(id):
	if lawyers[id]:
		lawyers[id] = false
		law_num -= 1

	for object in get_children():
		if object.is_in_group("lane"):
			object.change_difficulty(law_num)

func _on_Button_pressed():
	get_tree().change_scene("res://Main/Main.tscn")

func _on_Timer_timeout():
	end_game()
