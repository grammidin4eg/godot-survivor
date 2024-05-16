extends Timer

const AIM = preload("res://scenes/aim.tscn")

func _ready():
	randomize()
	
func _on_timeout():
	var aim = AIM.instantiate()
	# %SpawnMarker
	%SpawnPathFollow.progress_ratio = snapped(randf_range(0, 1), 0.1)
	aim.global_position = %SpawnPathFollow/SpawnMarker.global_position
	get_node('/root/main').add_child(aim)
