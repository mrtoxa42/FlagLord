extends CharacterBody2D


var up_coin = preload("res://Scenes/Others/upcoin.tscn")


@onready var attack_raycast = $AttackRaycast
@onready var line_raycast = $LineRaycast
@onready var nav = $NavigationAgent2D
var currentenemy
var attacked = false
#var attack_speed = 1.2
var enemy_value = 5
var speed = 200
var hp = 3
var attack_damage = 1
var take_attack 
var death = false
var col_raycast = false

func _ready() -> void:
	$HealthBar.max_value = hp
	
func _process(delta: float) -> void:
		pass

func _physics_process(delta: float) -> void: 
	
	$HealthBar.value = hp
	if currentenemy == null and col_raycast == false and death == false:
		var direction = Vector3()
		nav.target_position = GameManager.path1start.global_position
		direction = nav.get_next_path_position() - global_position
		if nav.distance_to_target() >= 72:
			velocity = direction.normalized() * speed
			$AnimationPlayer.play("Walk")
			move_and_slide()
		else:
			$AnimationPlayer.play("Idle")
	if currentenemy == null and attacked == false and col_raycast == true:
		$AnimationPlayer.play("Idle")

	if attack_raycast.is_colliding():
		var collider = attack_raycast.get_collider()
		if collider != null and currentenemy == null:
			if collider.is_in_group("Soldier"):
				currentenemy = collider.get_owner()
				$AnimationPlayer.play("Idle")
				$AttackTimer.start()
				if attacked == false:
					_Attack()
			
	else:
		currentenemy = null
	
	if line_raycast.is_colliding():
		var collider = line_raycast.get_collider()
		if collider != null:
			if collider.is_in_group("Enemy"):
				col_raycast = true
			else:
				col_raycast = false
	else:
		col_raycast = false
	



func _Attack():
	if currentenemy != null and death == false:
			attacked = true
			$AnimationPlayer.play("Attack")
			if currentenemy != null:
				currentenemy.take_attack = attack_damage
				currentenemy.take_damage()
			await $AnimationPlayer.animation_finished
			attacked = false
			#_Attack()
			$AttackTimer.start()
	else:
		attacked = false

func take_damage():
	hp -= take_attack
	if hp >0:
		$AnimationPlayer.play("Hit")
	else:
		_Death()

func _Death():
	var Up_Coin = up_coin.instantiate()
	Up_Coin.value_enemy = enemy_value
	get_tree().get_root().add_child(Up_Coin)
	Up_Coin.global_position = global_position
	$AnimationPlayer.play("Death")
	death = true
	await $AnimationPlayer.animation_finished
	queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Attack":
		attacked = false
	


func _on_attack_timer_timeout() -> void:
	attacked = false
	_Attack()
