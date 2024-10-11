extends Node

#Sistem değişkenleri
var GUI 

#Genel değişkenler
var gold = 2000




# Oyun içi değişkenler
var current_war_area
var coin_pos

var path1end
var path1start
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("R"):
		var root = get_tree().root
		for child in root.get_children():
			if !child.name == "GameManager":
				child.queue_free()
		var timer = get_tree().create_timer(0.2)
		await timer.timeout
		get_tree().change_scene_to_file("res://Scenes/WarArea/war_area_1.tscn")
		#var scene = load("res://Scenes/WarArea/war_area_1.tscn").instantiate()
		#get_tree().get_root().add_child(scene)
