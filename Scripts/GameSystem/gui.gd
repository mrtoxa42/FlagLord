extends CanvasLayer


func _process(delta: float) -> void:
	$Info/CoinLabel.text = str(GameManager.gold)


func _on_buy_swordman_pressed() -> void:
	GameManager.current_war_area.Buy_Swordman()
 


func _on_buy_halberdman_pressed() -> void:
	GameManager.current_war_area.Buy_Halberdman()


func _on_buy_archerman_pressed() -> void:
	GameManager.current_war_area.Buy_Archerman()
