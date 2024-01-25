extends CardState

var played: bool

func enter() -> void:	
	played = false
	
	if not card_ui.targets.is_empty():
		played = true
		print("Play card for target(s): ", card_ui.targets)

func on_input(_event: InputEvent) -> void:
	if played:
		return
	
	transition_requested.emit(self, CardState.State.BASE)
