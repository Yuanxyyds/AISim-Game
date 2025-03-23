# Assuming your chat UI is under a node called "Control"
extends Node2D

func _ready():
	$Control.show_chat("Catherine", "I have something important to share.")
