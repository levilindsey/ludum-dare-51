class_name ThrowUtils
extends Reference


# Adapted from https://github.com/forrestthewoods/lib_fts/blob/master/code/fts_ballistic_trajectory.cs#L285
static func calculate_start_velocity(
        start_speed: float,
        acceleration_y: float,
        start_position: Vector2,
        end_position: Vector2,
        uses_lower_angle := true) -> Vector2:
    var start_speed_squared := start_speed * start_speed
    var displacement := end_position - start_position
    var distance_x := abs(displacement.x)
    var discriminant := \
        start_speed_squared * start_speed_squared - \
        acceleration_y * acceleration_y * distance_x * distance_x - \
        2 * acceleration_y * displacement.y * start_speed_squared
    
    if discriminant < 0.0:
        # The target is out of reach.
        return Vector2.INF
    
    var root := sqrt(discriminant)
    
    var lower_angle := atan2(start_speed_squared - root, acceleration_y * distance_x)
    var upper_angle := atan2(start_speed_squared + root, acceleration_y * distance_x)
    var start_angle := lower_angle if uses_lower_angle else upper_angle
    
    var start_velocity := Vector2(
        cos(start_angle) * start_speed,
        sin(start_angle) * start_speed)
    if displacement.x < 0:
        start_velocity.x *= -1
    
    return start_velocity
