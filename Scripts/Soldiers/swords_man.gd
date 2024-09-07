extends CharacterBody2D

@onready var nav = $NavigationAgent2D
var speed = 200
func _physics_process(delta: float) -> void:
	var direction = Vector3()
	nav.target_position = GameManager.path1end.global_position
	direction = nav.get_next_path_position() - global_position
	if nav.distance_to_target() >= 72:
		velocity = direction.normalized() * speed
		move_and_slide()
	else:
		$AnimationPlayer.play("Idle")
