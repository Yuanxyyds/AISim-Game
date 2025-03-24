extends Node

var websocket := WebSocketPeer.new()
var control_node = null 
var is_connected := false

func _ready():
	var url = "ws://192.168.2.103:8000/ws"
	var state = websocket.connect_to_url(url)
	control_node = get_tree().get_root().get_node("Town/Control")
	
func _process(delta):
	websocket.poll()
	var state = websocket.get_ready_state()
	if state == WebSocketPeer.STATE_OPEN:
		while websocket.get_available_packet_count():
			var packet = websocket.get_packet()
			var json_string = packet.get_string_from_utf8()
			var message = JSON.parse_string(json_string)
			control_node.show_chat(message["message"], message["content"])
			print(message)
	elif state == WebSocketPeer.STATE_CLOSING:
		# Keep polling to achieve proper close.
		pass
	elif state == WebSocketPeer.STATE_CLOSED:
		var code = websocket.get_close_code()
		var reason = websocket.get_close_reason()
		print("WebSocket closed with code: %d, reason %s. Clean: %s" % [code, reason, code != -1])
		set_process(false) # Stop processing.
