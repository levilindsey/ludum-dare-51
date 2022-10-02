class_name ProjectileController
extends Node2D


func _physics_process(_delta: float) -> void:
    if Engine.editor_hint:
        return
    
    # FIXME: LEFT OFF HERE: -------------------------
    # FIXME: --------------: Iterate across projectiles on level and update physics
    pass


func on_projectile_added(projectile: Projectile) -> void:
    pass


func on_projectile_removed(projectile: Projectile) -> void:
    pass
