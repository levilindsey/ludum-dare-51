class_name WorkerSpawnController
extends Node2D


var previous_cooldown_count := 0


func _physics_process(_delta: float) -> void:
    if Engine.editor_hint:
        return
    
    if Game.cooldown_count != previous_cooldown_count:
        previous_cooldown_count = Game.cooldown_count
        trigger_spawn()


func trigger_spawn() -> void:
    Sc.level.add_worker(CommandType.SMALL_WORKER)


func on_worker_added(worker: Worker) -> void:
    pass


func on_worker_removed(worker: Worker) -> void:
    pass
