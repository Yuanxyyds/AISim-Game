extends Control

func show_chat(speaker: String, text: String):
	# Update chat text
	$Label.text = text

	# Hide all portraits
	$Chatbox.visible = true
	$Label.visible = true
	$Alice.visible = false
	$Catherine.visible = false

	# Show only the speaker's portrait
	match speaker:
		"Alice":
			$Alice.visible = true
		"Catherine":
			$Catherine.visible = true
