@tool
class_name LootTable
extends Resource

@export var level: int = 1
@export var entries: Array[LootEntry] = []

var weight_sum: int = 0


func add_entry(entry: LootEntry) -> void:
	entries.append(entry)
	weight_sum += entry.weight


func insert_entry(index: int, entry: LootEntry) -> void:
	entries.insert(index, entry)
	weight_sum += entry.weight


func remove_entry(index: int) -> void:
	if index >= 0 and index < entries.size():
		weight_sum -= entries[index].weight
		entries.remove_at(index)


func remove_last_entry() -> void:
	if entries.size() > 0:
		remove_entry(entries.size() - 1)


func calculate_weight_sum() -> void:
	for entry in entries:
		weight_sum += entry.weight


func pick_loot() -> LootEntry:
	var chosen_weight = randi_range(0, weight_sum)
	var iteration_sum = 0
	for entry in entries:
		iteration_sum += entry.weight
		if chosen_weight <= iteration_sum:
			return entry
	printerr("Couldn't find a loot to pick %f" % chosen_weight)
	return null
