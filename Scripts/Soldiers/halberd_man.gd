extends CharacterBody2D

@onready var nav = $NavigationAgent2D
var speed = 140


var currentenemy
var attacked = false
var hp = 5
var attack_damage = 1
var death = false

func _ready() -> void:
	$HealthBar.max_value = hp

func _physics_process(delta: float) -> void:
	$HealthBar.value = hp
	if currentenemy == null:
		var direction = Vector3()
		nav.target_position = GameManager.path1end.global_position
		direction = nav.get_next_path_position() - global_position
		if nav.distance_to_target() >= 72:
			velocity = direction.normalized() * speed
			$AnimationPlayer.play("Walk")
			move_and_slide()
		else:
			$AnimationPlayer.play("Idle")


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy") and currentenemy == null:
		$AnimationPlayer.play("Idle")
		currentenemy = area.get_owner()
		_Attack()


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area == currentenemy:
		currentenemy = null



func _Attack():
	if currentenemy != null and death == false:
		attacked = true
		$AnimationPlayer.play("Attack")
		if currentenemy != null:
			currentenemy.take_attack = 2
			currentenemy.take_damage()
		await $AnimationPlayer.animation_finished
		attacked = false
		var timer = get_tree().create_timer(1.2)
		await timer.timeout
		_Attack()

func take_damage():
	hp-= attack_damage
	if hp >0:
		$AnimationPlayer.play("Hit")
	else:
		_Death()

func _Death():
	$AnimationPlayer.play("Death")
	death = true
	await $AnimationPlayer.animation_finished
	queue_free()
