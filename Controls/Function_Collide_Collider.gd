extends KinematicBody

export (NodePath) var target

func _physics_process(_delta):
	if target != null:
		var catch_up_vec : Vector3 = target.global_transform.origin - self.global_transform.origin
		var collision := move_and_collide(catch_up_vec,true)
		if collision:
			if collision.remainder.length_squared()>0.5:
				if not test_move(target.global_transform,Vector3(),false):
					# No collision would occur if we were where we should be
					self.global_transform = target.global_transform
				# else: wait for them to get their hand to free space
			# else: we should be close enough
		# else: we should be where we need to be alredady
