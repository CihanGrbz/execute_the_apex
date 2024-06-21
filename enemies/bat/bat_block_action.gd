extends EnemyAction

@export var block := 4

func perform_action():
	if not enemy or not target:
		return
	
	var tween := create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_IN)
	var start := enemy.global_position
	var end := start + Vector2.UP * 10
	var target_array: Array[Node] = [enemy]
	var block_effect := BlockEffect.new()
	block_effect.amount = block
	block_effect.sound = sound
	
	tween.tween_property(enemy, "global_position", end, 0.17)
	tween.tween_callback(block_effect.execute.bind(target_array))
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(enemy, "global_position", start, 0.17)
	
	tween.finished.connect(
		func():
			Events.enemy_action_completed.emit(enemy)
	)
	

