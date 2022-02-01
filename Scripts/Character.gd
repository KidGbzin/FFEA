extends KinematicBody2D

var _gravity = 64
var _jump_force = 1280
var _speed = 500
var _velocity = Vector2()

func _physics_process(delta):
	var _horizontal_direction = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	
	_velocity.x = _horizontal_direction * _speed
	_velocity.y += _gravity
	
	var is_falling = _velocity.y > 0.0 and not is_on_floor()
	var is_idling = is_on_floor() and is_zero_approx(_velocity.x)
	var is_jump_cancelled = Input.is_action_just_released("ui_up") and _velocity.y < 0.0
	var is_walking = is_on_floor() and not is_zero_approx(_velocity.y)
	
	if (Input.is_action_just_pressed("ui_up") and is_on_floor()):
		_velocity.y -= _jump_force
		$Animation.play("Jump")
	
	_velocity = move_and_slide(_velocity, Vector2.UP)
