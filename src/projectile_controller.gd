class_name ProjectileController
extends Node2D


func _physics_process(delta: float) -> void:
    if Engine.editor_hint:
        return
    
    var scaled_delta := Sc.time.scale_delta(delta)
    
    # Iterate across projectiles on level and update physics.
    for projectile in Sc.level.projectiles:
        projectile.position += projectile.velocity * scaled_delta
        projectile.velocity += \
            Vector2(0.0, Su.movement.gravity_default * scaled_delta)
        
        # Clean-up out-of-bounds projectiles.
        if projectile.position.y > 4000.0:
            Sc.level.remove_projectile(projectile)


func shoot_at_target(
        shooter_entity_command_type: int,
        upgrade_type: int,
        tower_upgrade_type: int,
        target_position: Vector2,
        start_position: Vector2) -> void:
    # FIXME: -------- Update arrow rotation.
    # FIXME: -------- Check if the target has a velocity and if the horizontal velocity is greater than some threshold; if so, add an offset to the shot
    
    var projectile_type := \
        Projectile.get_projectile_type_for_command_type(shooter_entity_command_type)
    
    var start_speed := ProjectileSpeeds.get_speed(
        shooter_entity_command_type,
        upgrade_type,
        tower_upgrade_type)
    
    var uses_lower_angle := false
    var start_velocity := ThrowUtils.calculate_start_velocity(
        start_speed,
        Su.movement.gravity_default,
        start_position,
        target_position,
        uses_lower_angle)
    
    if start_velocity == Vector2.INF:
        # Target is out of reach, so fall-back to a 45-degree angle to shoot
        # pretty far toward the target.
        start_velocity = Vector2.RIGHT.rotated(-PI / 4.0)
        if target_position.x < start_position.x:
            start_velocity.x *= -1.0
    
    Sc.level.add_projectile(
        projectile_type,
        start_position,
        start_velocity)


func on_projectile_added(projectile: Projectile) -> void:
    pass


func on_projectile_removed(projectile: Projectile) -> void:
    pass
