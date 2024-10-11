extends Node2D

var value_enemy: int

var coin_pos

func _ready() -> void:
	coin_pos = GameManager.coin_pos + Vector2(920,30)
	var tween = get_tree().create_tween()
	tween.tween_property(self,"global_position",coin_pos,1)
	tween.connect("finished",tween_finished)

func tween_finished():
	GameManager.GUI.coin_up(value_enemy)
	queue_free()
