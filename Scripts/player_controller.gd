### Player Controller

extends KinematicBody2D

# _ready() is run when the node is added to the scene
func _ready():
	# Tell godot to call _process() life cycle function when in game loop
	self.set_process(true);

func _process(delta):

	# Check if a certain key is pressed...
	if (Input.is_key_pressed(KEY_D)):
		# And move self five pixels in the corresponding direction
		self.move_and_slide(Vector2(200, 0))

	if (Input.is_key_pressed(KEY_A)):
		self.move_and_slide(Vector2(-200, 0))
	if (Input.is_key_pressed(KEY_W)):
		self.move_and_slide(Vector2(0, -200))
	if (Input.is_key_pressed(KEY_S)):
		self.move_and_slide(Vector2(0, 200))