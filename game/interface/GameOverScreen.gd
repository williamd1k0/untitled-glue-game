extends Control


func set_final_score(score):
	$FinalScoreLabel.text = "Score: %d" % score
	$BestScoreLabel.text = "Best: %d" % LocalScore.best_score

func _on_RetryButton_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_GameOverScreen_draw():
	$RetryButton.grab_focus()
