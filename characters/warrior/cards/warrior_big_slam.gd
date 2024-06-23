extends Card


func apply_effects(targets: Array[Node]):
	var damage_effect := DamageEffect.new()
	damage_effect.amount = 10
	damage_effect.sound = sound
	damage_effect.execute(targets)
	print("TODO: Implement status effects! Just imagine, uh, you applied 2 exposed. Yeah..")
	
