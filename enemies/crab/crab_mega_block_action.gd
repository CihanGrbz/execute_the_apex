extends EnemyAction

@export var block := 15
@export var hp_threshold := 5

var already_used := false

func is_performable() -> bool:
	if not enemy or already_used:
		return false
	
	var is_low := enemy.stats.health <= hp_threshold
	already_used = is_low
	
	return is_low
	

func perform_action() -> void:
	if not enemy or not target:
		return
	
	var tween := create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_IN)
	var start := enemy.global_position
	var end := start + Vector2.UP * 15
	var target_array: Array[Node] = [enemy]
	var block_effect := BlockEffect.new()
	block_effect.amount = block
	block_effect.sound = sound
	
	var shake_duration = 0.3
	Shaker.shake(enemy, 7, shake_duration)
	
	tween.tween_interval(shake_duration)
	tween.tween_property(enemy, "global_position", end, 0.17)
	tween.tween_callback(block_effect.execute.bind(target_array))
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(enemy, "global_position", start, 0.17)
	
	tween.finished.connect(
		func():
			Events.enemy_action_completed.emit(enemy)
	)
	
