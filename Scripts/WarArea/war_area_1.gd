extends Node2D

var swordman = preload("res://Scenes/Soldiers/sword_man.tscn")
var halberdman = preload("res://Scenes/Soldiers/halberd_man.tscn")
var archerman = preload("res://Scenes/Soldiers/archer_man.tscn")
var enemy_swordman = preload("res://Scenes/Soldiers/enemy_sword_man.tscn")
func _ready() -> void:
	GameManager.path1end = $Paths/Path1/Path1End
	GameManager.path1start = $Paths/Path1/Path1Start
	GameManager.current_war_area = self

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_select"):
		var Enemy_swordman = enemy_swordman.instantiate()
		get_tree().get_root().add_child(Enemy_swordman)
		Enemy_swordman.global_position = $Paths/Path1/Path1End.global_position
		
	if Input.is_action_just_pressed("1"):
		Buy_Swordman()
	if Input.is_action_just_pressed("2"):
		Buy_Halberdman()
	if Input.is_action_just_pressed("3"):
		Buy_Archerman()

func Buy_Swordman():
	if GameManager.gold >= 10:
		var Swordman =swordman.instantiate()
		get_tree().get_root().add_child(Swordman)
		Swordman.global_position = GameManager.path1start.global_position
		GameManager.gold -= 10
	
func Buy_Halberdman():
	if GameManager.gold >= 10:
		var Halberdman =halberdman.instantiate()
		get_tree().get_root().add_child(Halberdman)
		Halberdman.global_position = GameManager.path1start.global_position
		GameManager.gold -= 15
		
func Buy_Archerman():
	if GameManager.gold >= 25:
		var Archerman = archerman.instantiate()
		get_tree().get_root().add_child(Archerman)
		Archerman.global_position = GameManager.path1start.global_position
		GameManager.gold -= 25

func _on_path_1_spawner_timeout() -> void:
	var Enemy_swordman = enemy_swordman.instantiate()
	get_tree().get_root().add_child(Enemy_swordman)
	Enemy_swordman.global_position = $Paths/Path1/Path1End.global_position
