extends Control


func set_final_score(score):
	$FinalScoreLabel.text = "Score: %s" % score


func _on_RetryButton_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_GameOverScreen_draw():
	$RetryButton.grab_focus()
