extends CanvasLayer

#Notifies 'Main' node that the button has been pressed
signal start_game
signal pause_game
var Name = ""

func _ready():
	$PauseButton.hide()
	$ContinueButton.hide()

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	#Wait until the MessageTimer has count down
	await $MessageTimer.timeout
	$Label.show()
	$Message.text = "Dodge the\nCreeps"
	$Message.show()
	#Make oneshot timer and wait for it to finish
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	$Name.show()
	
func update_score(Score):
	$ScoreLabel.text = str(Score)

func updatehigh(high_score):
	$highscore.text = str(high_score)

func _on_message_timer_timeout():
	$Message.hide()


func _on_start_button_pressed():
	Name = get_node("Name").get_text()
	if(Name == ""):
		Name = "Player"
	$StartButton.hide()
	$Name.hide()
	$PauseButton.show()
	$ContinueButton.hide()
	start_game.emit()

func _on_pause_button_pressed():
	get_tree().paused = true
	$PauseButton.hide()
	$ContinueButton.show()

func _on_continue_button_pressed():
	$PauseButton.show()
	$ContinueButton.hide()
	get_tree().paused = false
