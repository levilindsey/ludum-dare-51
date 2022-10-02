class_name WorkerSpawnController
extends Node2D


const MONEY_PER_WAVE := 200

var previous_cooldown_count := 0


func _physics_process(_delta: float) -> void:
    if Engine.editor_hint:
        return
    
    if Game.cooldown_count != previous_cooldown_count:
        previous_cooldown_count = Game.cooldown_count
        trigger_spawn()
        trigger_money()


func trigger_spawn() -> void:
    Sc.level.add_worker(CommandType.SMALL_WORKER)


func trigger_money() -> void:
    var amount := MONEY_PER_WAVE * pow(1.2, Game.cooldown_count)
    Sc.level.add_money(amount)


func on_worker_added(worker: Worker) -> void:
    pass


func on_worker_removed(worker: Worker) -> void:
    pass
