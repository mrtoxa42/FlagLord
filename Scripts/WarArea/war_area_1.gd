extends Node2D

var swordman = preload("res://Scenes/Soldiers/sword_man.tscn")
var halberdman = preload("res://Scenes/Soldiers/halberd_man.tscn")
var archerman = preload("res://Scenes/Soldiers/archer_man.tscn")
var enemy_swordman = preload("res://Scenes/Soldiers/enemy_sword_man.tscn")
var is_pressed = false

var wave = 0




func _ready() -> void:
	GameManager.path1end = $Paths/Path1/Path1End
	GameManager.path1start = $Paths/Path1/Path1Start
	GameManager.current_war_area = self

	var timer = get_tree().create_timer(1)
	await timer.timeout
	_Wave1()
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_select"):
		enemy_swordman_spawn()
		
	
	if Input.is_action_just_pressed("1"):
		if is_pressed == false:
			Buy_Swordman()
			is_pressed = true
			var timer = get_tree().create_timer(0.3)
			await timer.timeout
			is_pressed = false
			get_tree()
	if Input.is_action_just_pressed("2"):
		if is_pressed == false:
			Buy_Halberdman()
			is_pressed = true
			var timer = get_tree().create_timer(0.3)
			await timer.timeout
			is_pressed = false
			get_tree()
	if Input.is_action_just_pressed("3"):
		if is_pressed == false:
			Buy_Archerman()
			is_pressed = true
			var timer = get_tree().create_timer(0.3)
			await timer.timeout
			is_pressed = false
			get_tree()

func Buy_Swordman():
	if GameManager.gold >= 10:
		var Swordman =swordman.instantiate()
		get_tree().get_root().add_child(Swordman)
		Swordman.global_position = GameManager.path1start.global_position
		GameManager.gold -= 10
		GameManager.GUI.current_buy_coin = 10
		GameManager.GUI.coin_buy_ani()
	else:
		GameManager.GUI.coin_buy_ani()
func Buy_Halberdman():
	if GameManager.gold >= 10:
		var Halberdman =halberdman.instantiate()
		get_tree().get_root().add_child(Halberdman)
		Halberdman.global_position = GameManager.path1start.global_position
		GameManager.gold -= 15
		GameManager.GUI.current_buy_coin = 15
		GameManager.GUI.coin_buy_ani()
	else:
		GameManager.GUI.coin_buy_ani()
func Buy_Archerman():
	if GameManager.gold >= 25:
		var Archerman = archerman.instantiate()
		get_tree().get_root().add_child(Archerman)
		Archerman.global_position = GameManager.path1start.global_position
		GameManager.gold -= 25
		GameManager.GUI.current_buy_coin = 25
		GameManager.GUI.coin_buy_ani()
	else:
		GameManager.GUI.coin_buy_ani()
func _on_path_1_spawner_timeout() -> void:
	var Enemy_swordman = enemy_swordman.instantiate()
	get_tree().get_root().add_child(Enemy_swordman)
	Enemy_swordman.global_position = $Paths/Path1/Path1End.global_position


func enemy_swordman_spawn():
	var Enemy_swordman = enemy_swordman.instantiate()
	get_tree().get_root().add_child(Enemy_swordman)
	Enemy_swordman.global_position = $Paths/Path1/Path1End.global_position
	


func _Wave1():
	var spawn_count_soldier = 5
	
	for i in range(spawn_count_soldier):
		var timer = get_tree().create_timer(0.5)
		await timer.timeout
		enemy_swordman_spawn()

	
