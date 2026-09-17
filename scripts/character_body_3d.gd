extends CharacterBody3D

@onready var camera_pivot = $CameraPivot
@onready var interact_ui = $CanvasLayer/Interact

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.005

var inventory = []

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(event.relative.x * -MOUSE_SENSITIVITY)
		# Make the camera not do 360s using clamp
		camera_pivot.rotation.x = clamp(camera_pivot.rotation.x + event.relative.y * -MOUSE_SENSITIVITY, -PI/2, PI/2)

func interact():
	interact_ui.visible = true
func stop_interact():
	interact_ui.visible = false

func get_key():
	inventory.append("key")
