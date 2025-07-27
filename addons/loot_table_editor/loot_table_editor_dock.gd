@tool
extends VBoxContainer

var database: LootTableDatabase

var database_picker: EditorResourcePicker
var tables_list: ItemList
var add_table_button: Button
var table_editor: VBoxContainer


func _ready():
	_build_ui()


func _build_ui():
	_create_database_picker()
	_create_tables_list()
	_create_add_table_button()
	_create_editor_panel()


func _create_database_picker():
	database_picker = EditorResourcePicker.new()
	database_picker.base_type = "LootTableDatabase"
	database_picker.editable = true
	database_picker.connect("resource_changed", Callable(self, "_on_database_selected"))
	add_child(database_picker)


func _create_tables_list():
	tables_list = ItemList.new()
	tables_list.connect("item_selected", Callable(self, "_on_table_selected"))
	add_child(tables_list)


func _create_add_table_button():
	add_table_button = Button.new()
	add_table_button.text = "Add Table"
	add_table_button.connect("pressed", Callable(self, "_on_add_table_pressed"))
	add_child(add_table_button)


func _create_editor_panel():
	var scroll = ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	table_editor = VBoxContainer.new()
	table_editor.size_flags_vertical = Control.SIZE_EXPAND_FILL
	table_editor.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	scroll.add_child(table_editor)
	add_child(scroll)


# Selection and refresh
func _on_database_selected(resource: Resource) -> void:
	database = resource
	_clear_tables_ui()
	if database:
		_refresh_tables_list()
		_render_all_tables()


func _refresh_tables_list() -> void:
	tables_list.clear()
	if not database:
		return
	for i in range(database.tables.size()):
		var table = database.tables[i]
		var label = "Table %d – Level %d (%d entries)" % [i, table.level, table.entries.size()]
		tables_list.add_item(label)


# Table creation handlers
func _on_add_table_pressed() -> void:
	if not database:
		return
	database.add_table(LootTable.new())
	_on_database_selected(database)


func _on_table_selected(index: int) -> void:
	_ensure_selection_valid(index)


func _ensure_selection_valid(index: int) -> void:
	if not database:
		return
	index = clamp(index, 0, database.tables.size() - 1)
	_clear_tables_ui()
	_build_table_panel(index)


# UI rendering
func _clear_tables_ui() -> void:
	tables_list.clear()
	for child in table_editor.get_children():
		child.queue_free()


func _render_all_tables() -> void:
	for i in range(database.tables.size()):
		_build_table_panel(i)


func _build_table_panel(index: int) -> void:
	var table = database.tables[index]
	var container = VBoxContainer.new()
	container.add_theme_constant_override("separation", 8)
	
	container.add_child(_create_table_header(index))
	container.add_child(_create_level_row(table))
	container.add_child(_create_entries_header(table))
	
	for i in range(table.entries.size()):
		container.add_child(_create_entry_row(table, i))
	
	container.add_child(_create_add_entry_button(table))
	table_editor.add_child(container)


func _create_table_header(index: int) -> HBoxContainer:
	var h = HBoxContainer.new()
	var label = Label.new()
	label.text = "Table %d" % index
	h.add_child(label)
	
	var button = Button.new()
	button.text = "Remove Table"
	button.connect("pressed", Callable(self, "_on_remove_table_pressed").bind(index))
	h.add_child(button)
	return h


func _create_level_row(table: LootTable) -> HBoxContainer:
	var h = HBoxContainer.new()
	var label = Label.new()
	label.text = "Level:"
	h.add_child(label)

	var spin = SpinBox.new()
	spin.min_value = 0
	spin.value = table.level
	spin.connect("value_changed", Callable(self, "_on_level_changed").bind(table))
	h.add_child(spin)
	return h


func _create_entries_header(table: LootTable) -> Label:
	var label = Label.new()
	label.text = "Entries [Loot] [Amount] [Weight] (%d):" % table.entries.size()
	return label


func _create_entry_row(table: LootTable, index: int) -> HBoxContainer:
	var entry = table.entries[index]
	var h = HBoxContainer.new()
	
	var picker = EditorResourcePicker.new()
	picker.base_type = "PackedScene"
	picker.editable = true
	picker.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	picker.custom_minimum_size = Vector2(50, 50)
	picker.edited_resource = entry.loot
	picker.connect("resource_changed", Callable(self, "_on_loot_changed").bind(entry))
	h.add_child(picker)
	
	var amount_spin = SpinBox.new()
	amount_spin.min_value = 0
	amount_spin.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	amount_spin.value = entry.amount
	amount_spin.connect("value_changed", Callable(self, "_on_amount_changed").bind(entry))
	h.add_child(amount_spin)
	
	var weight_spin = SpinBox.new()
	weight_spin.min_value = 0
	weight_spin.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	weight_spin.value = entry.weight
	weight_spin.connect("value_changed", Callable(self, "_on_weight_changed").bind(entry))
	h.add_child(weight_spin)
	
	var button = Button.new()
	button.text = "×"
	button.connect("pressed", Callable(self, "_on_remove_entry_pressed").bind(table, index))
	h.add_child(button)
	
	return h


func _create_add_entry_button(table: LootTable) -> Button:
	var button = Button.new()
	button.text = "Add Entry"
	button.connect("pressed", Callable(self, "_on_add_entry_pressed").bind(table))
	return button


# Mutation callbacks
func _on_remove_table_pressed(index: int) -> void:
	database.remove_table(index)
	_on_database_selected(database)


func _on_remove_entry_pressed(table: LootTable, index: int) -> void:
	table.remove_entry(index)
	_on_database_selected(database)


func _on_level_changed(value: float, table: LootTable) -> void:
	table.level = int(value)
	_on_database_selected(database)


func _on_loot_changed(resource: Resource, entry: LootEntry) -> void:
	entry.loot = resource
	_on_database_selected(database)


func _on_amount_changed(value: float, entry: LootEntry) -> void:
	entry.amount = int(value)
	_on_database_selected(database)


func _on_weight_changed(value: float, entry: LootEntry) -> void:
	entry.weight = int(value)
	_on_database_selected(database)


func _on_add_entry_pressed(table: LootTable) -> void:
	table.add_entry(LootEntry.new())
	_on_database_selected(database)
