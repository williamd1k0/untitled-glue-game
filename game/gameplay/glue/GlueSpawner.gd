extends Position2D


export(NodePath) var container_path
export(PackedScene) var glue_scene
export(Resource) var glue_charge


func _ready():
	glue_charge.connect("recharged", self, "_on_GlueCharge_recharged")


func spawn():
	var glue = glue_scene.instance()
	glue.global_position = global_position
	
	get_node(container_path).add_child(glue)


func _on_GlueCharge_recharged():
	spawn()
