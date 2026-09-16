extends StaticBody3D

var player = null
var took_key = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (player != null) and Input.is_action_just_pressed("interact"):
		if took_key:
			print("there are no more keys.")
		if not took_key:
			print("there is a key here...you took it.")
			took_key = true
			player.get_key()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		print("interact ? (E)")
		player = body


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is CharacterBody3D:
		player = null
