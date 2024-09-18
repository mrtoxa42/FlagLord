extends CharacterBody2D

@onready var nav = $NavigationAgent2D
@onready var attack_raycast = $AttackRaycast
var speed = 160


var currentenemy
var death = false
var take_attack = 1
var hp = 3
var attacked = false
var col_attack_raycast = false


func _ready() -> void:
	$HealthBar.max_value = hp
func _physics_process(delta: float) -> void:
	$HealthBar.value = hp
	if currentenemy == null and death == false:
		var direction = Vector3()
		nav.target_position = GameManager.path1start.global_position
		direction = nav.get_next_path_position() - global_position
		if nav.distance_to_target() >= 72:
			$AnimationPlayer.play("Walk")
			velocity = direction.normalized() * speed
			move_and_slide()



	if attack_raycast.is_colliding():
		var collider = attack_raycast.get_collider()
		if collider != null and currentenemy == null:
			if collider.is_in_group("Soldier"):
				currentenemy = collider.get_owner()
				$AnimationPlayer.play("Idle")
				$AttackTimer.start()
			else:
				currentenemy = null
	else:
		currentenemy = null

func _Attack():
	if currentenemy != null and death == false:
			attacked = true
			$AnimationPlayer.play("Attack")
			if currentenemy != null:
				currentenemy.take_attack = 1
				currentenemy.take_damage()
			await $AnimationPlayer.animation_finished
			attacked = false
			#_Attack()
			$AttackTimer.start()
	else:
		attacked = false

func take_damage():
	hp-= take_attack
	if hp >0:
		$AnimationPlayer.play("Hit")
	else:
		_Death()

func _Death():
	$AnimationPlayer.play("Death")
	death = true
	await $AnimationPlayer.animation_finished
	queue_free()


func _on_attack_timer_timeout() -> void:
	attacked = false
	_Attack()
