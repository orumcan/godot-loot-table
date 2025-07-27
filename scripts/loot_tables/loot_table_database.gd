@tool
@icon("res://chest_icon.png")
class_name LootTableDatabase
extends Resource

@export var tables: Array[LootTable] = []


func add_table(table: LootTable) -> void:
	tables.append(table)


func insert_table(index: int, table: LootTable) -> void:
	tables.insert(index, table)


func remove_table(index: int) -> void:
	if index >= 0 and index < tables.size():
		tables.remove_at(index)


func remove_last_table() -> void:
	if tables.size() > 0:
		tables.remove_at(tables.size() - 1)


func initialize() -> void:
	for table in tables:
		table.calculate_weight_sum()


func pick_loot_by_level(level: int) -> LootEntry:
	for i in range(tables.size() -1, -1, -1):
		var table = tables[i]
		if table.level <= level:
			return table.pick_loot()

	printerr("Couldn't find a table loot to pick for level %d" % level)
	return null
