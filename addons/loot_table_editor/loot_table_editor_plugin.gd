@tool
extends EditorPlugin

var dock


func _enter_tree():
	dock = preload("res://addons/loot_table_editor/loot_table_editor_dock.gd").new()
	dock.custom_minimum_size = Vector2(300, 400)
	dock.name = "Loot Table Editor"
	add_control_to_dock(DOCK_SLOT_LEFT_UL, dock)


func _exit_tree():
	remove_control_from_docks(dock)
	dock.free()


func get_selected_database() -> LootTableDatabase:
	return dock.database
