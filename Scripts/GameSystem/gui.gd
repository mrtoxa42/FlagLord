extends CanvasLayer

var current_buy_coin 

func _ready() -> void:
	GameManager.GUI = self

func _process(delta: float) -> void:
	$Info/CoinLabel.text = str(GameManager.gold)
	
	if Input.is_action_just_pressed("1"):
		$"Keyboards/1".play("default")
	if Input.is_action_just_pressed("2"):
		$"Keyboards/2".play("default")
	if Input.is_action_just_pressed("3"):
		$"Keyboards/3".play("default")

func _on_buy_swordman_pressed() -> void:
	GameManager.current_war_area.Buy_Swordman()
 


func _on_buy_halberdman_pressed() -> void:
	GameManager.current_war_area.Buy_Halberdman()


func _on_buy_archerman_pressed() -> void:
	GameManager.current_war_area.Buy_Archerman()

func coin_buy_ani():
	$AniNodes/CoinBuyLabel.text = "-" + str(current_buy_coin)
	$AnimationPlayer.play("CoinAni")
	
