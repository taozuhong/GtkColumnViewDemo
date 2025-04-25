using Gtk;

public class FileInfoModel : GLib.Object {
    public string   name { get; set; default = ""; }
    public FileType kind { get; set; default = FileType.REGULAR; }
    public uint64   size { get; set; default = 0; }
    public DateTime date { get; set; default = new DateTime.now_local(); }

    public FileInfoModel()
    {
    }

    public FileInfoModel.with_name(string _name)
    {
        this.name = _name;
        this.kind = (FileType)GLib.Random.int_range(0, 6);
        this.size = GLib.Random.int_range(500, 1000000);
        this.date = new DateTime.now_local();
    }
}

[GtkTemplate (ui = "/taozuhong/datagrid/column.ui")]
public class GtkColumnViewDemoWindow : Gtk.ApplicationWindow {
    [GtkChild]
    private unowned Gtk.ToggleButton button_name;
    [GtkChild]
    private unowned Gtk.ToggleButton button_type;
    [GtkChild]
    private unowned Gtk.ToggleButton button_size;
    [GtkChild]
    private unowned Gtk.ToggleButton button_date;
    [GtkChild]
    private unowned Gtk.Notebook books;
    [GtkChild]
    private unowned Gtk.ColumnView view_signal;
    [GtkChild]
    private unowned Gtk.ColumnView view_builder;
    [GtkChild]
    private unowned Gtk.ColumnView view_mixed;
    [GtkChild]
    private unowned Gtk.ColumnView view_update;
    [GtkChild]
    private unowned Gtk.DirectoryList directory_list_signal;
    [GtkChild]
    private unowned Gtk.DirectoryList directory_list_builder;
    [GtkChild]
    private unowned Gtk.DirectoryList directory_list_mixed;
    [GtkChild]
    private unowned Gtk.SortListModel sort_model_update;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn signal_name;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn signal_type;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn signal_size;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn signal_date;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn builder_name;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn builder_type;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn builder_size;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn builder_date;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn mixed_name;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn mixed_type;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn mixed_size;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn mixed_date;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn column_update_name;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn column_update_type;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn column_update_size;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn column_update_date;
    [GtkChild]
    private unowned Gtk.PopoverMenu rows_popmenu_signal;
    [GtkChild]
    private unowned Gtk.PopoverMenu rows_popmenu_builder;
    [GtkChild]
    private unowned Gtk.PopoverMenu rows_popmenu_mixed;
    [GtkChild]
    private unowned Gtk.PopoverMenu rows_popmenu_update;

    private SimpleActionGroup simple_action_group;
    private GLib.ListStore m_model_update;
    private Gtk.StringList m_model_types;
    private unowned Binding binding_name;
    private unowned Binding binding_type;
    private unowned Binding binding_size;
    private unowned Binding binding_date;

    const string[] type_array = { "UNKNOWN", "REGULAR", "DIRECTORY", "SYMBOLIC_LINK", "SPECIAL", "SHORTCUT", "MOUNTABLE" };
    const ActionEntry[] action_entries = {
        { "show-name", show_name_handler, null, "true", null },
        { "show-type", show_type_handler, null, "true", null },
        { "show-size", show_size_handler, null, "true", null },
        { "show-date", show_date_handler, null, "true", null },

        { "show-table", show_table_handler, null, "false", null },
        { "show-list", show_list_handler, null, "false", null },
        { "show-sidebar", show_sidebar_handler, null, "true", null },

        { "select-all", select_all_handler },
        { "select-none", select_none_handler },
    };

    public GtkColumnViewDemoWindow(Gtk.Application app) {
        Object (application: app);

        typeof(FileInfoModel).ensure();

        m_model_types = new Gtk.StringList(type_array);

        m_model_update = new GLib.ListStore(typeof(FileInfoModel));
        this.sort_model_update.model = m_model_update;
        m_model_update.append(new FileInfoModel.with_name("column.ui"));
        m_model_update.append(new FileInfoModel.with_name("column.vala"));
        m_model_update.append(new FileInfoModel.with_name("application.vala"));


        File file = File.new_for_path(".");
        directory_list_signal.set_file(file);
        directory_list_builder.set_file(file);
        directory_list_mixed.set_file(file);

        var bind_flags = BindingFlags.SYNC_CREATE | BindingFlags.BIDIRECTIONAL;
        binding_name = this.button_name.bind_property("active", this.signal_name, "visible", bind_flags);
        binding_type = this.button_type.bind_property("active", this.signal_type, "visible", bind_flags);
        binding_size = this.button_size.bind_property("active", this.signal_size, "visible", bind_flags);
        binding_date = this.button_date.bind_property("active", this.signal_date, "visible", bind_flags);

        simple_action_group = new SimpleActionGroup();
        simple_action_group.add_action_entries(action_entries, this);
        this.insert_action_group("columnview", simple_action_group);

        this.add_css_class("devel");
    }

    [GtkCallback]
    private void signal_name_setup_handler(Gtk.SignalListItemFactory factory, GLib.Object listitem)
    {
        Gtk.Entry entry = new Gtk.Entry();
        entry.focusable = true;
        entry.secondary_icon_name = "accessories-text-editor";
        entry.secondary_icon_activatable = true;
        entry.secondary_icon_tooltip_text = "Click icon to edit it in large window";
        entry.xalign = 0.5f;
        (listitem as Gtk.ListItem).child = entry;
    }

    [GtkCallback]
    private void signal_name_bind_handler(Gtk.SignalListItemFactory factory, GLib.Object listitem)
    {
        Gtk.ListItem list_item = listitem as Gtk.ListItem;
        Gtk.Entry entry = list_item.child as Gtk.Entry;
        FileInfo? info = list_item.item as FileInfo;
        if (null != info) {
            entry.text = info.get_name();
            entry.primary_icon_gicon = get_icon_factory(list_item, info);
        } else {
            entry.text = "NULL";
        }
    }

    [GtkCallback]
    private void signal_type_setup_handler(Gtk.SignalListItemFactory factory, GLib.Object listitem)
    {
        var expression = new Gtk.PropertyExpression(typeof(Gtk.StringObject), null, "string");
        Gtk.DropDown dropdown = new Gtk.DropDown(m_model_types, expression);
        dropdown.valign = Gtk.Align.CENTER;
        dropdown.enable_search = true;
        (listitem as Gtk.ListItem).child = dropdown;
    }

    [GtkCallback]
    private void signal_type_bind_handler(Gtk.SignalListItemFactory factory, GLib.Object listitem)
    {
        Gtk.ListItem list_item = listitem as Gtk.ListItem;
        Gtk.DropDown dropdown = list_item.child as Gtk.DropDown;
        FileInfo? info = list_item.item as FileInfo;
        if (null != info) {
            dropdown.selected = GLib.Random.int_range(0, type_array.length - 1);
        } else {
            dropdown.selected = 0;
        }
    }

    [GtkCallback]
    private void signal_size_setup_handler(Gtk.SignalListItemFactory factory, GLib.Object listitem)
    {
        Gtk.Adjustment adjustment = new Gtk.Adjustment(0, 0, 1000000, 1, 10, 0);
        Gtk.SpinButton spin_button = new Gtk.SpinButton(adjustment, 1.0, 2);
        spin_button.focusable = true;
        spin_button.css_classes = { "vertical" };

        Gtk.ListItem list_item = listitem as Gtk.ListItem;
        list_item.child = spin_button;
    }

    [GtkCallback]
    private void signal_size_bind_handler(Gtk.SignalListItemFactory factory, GLib.Object listitem)
    {
        Gtk.ListItem list_item = listitem as Gtk.ListItem;
        Gtk.SpinButton spin_button = list_item.child as Gtk.SpinButton;
        FileInfo? info = list_item.item as FileInfo;
        if (null != info) {
            spin_button.value = (double)info.get_size();
        } else {
            spin_button.value = 0.0;
        }
    }

    [GtkCallback]
    private void signal_date_setup_handler(Gtk.SignalListItemFactory factory, GLib.Object listitem)
    {
        Gtk.Popover popover = new Gtk.Popover();
        Gtk.MenuButton button = new Gtk.MenuButton();
        button.focusable = true;
        button.popover = popover;
        Gtk.ListItem list_item = listitem as Gtk.ListItem;
        list_item.child = button;

        Gtk.Calendar calendar = new Gtk.Calendar();
        popover.child = calendar;
        calendar.set_data<Object>("OWNER", button);
        calendar.day_selected.connect((sender) => {
            var button_shadow = sender.get_data<Object>("OWNER") as Gtk.MenuButton;
            if (null != button_shadow) {
                var datetime = sender.get_date();
                button_shadow.label = datetime.format("%F");
            }
        });
    }

    [GtkCallback]
    private void signal_date_bind_handler(Gtk.SignalListItemFactory factory, GLib.Object listitem)
    {
        Gtk.ListItem list_item = listitem as Gtk.ListItem;
        Gtk.MenuButton button = list_item.child as Gtk.MenuButton;
        FileInfo? info = list_item.item as FileInfo;
        if (null != info) {
            DateTime datetime = info.get_modification_date_time ();
            button.label = datetime.format("%F");
        } else {
            button.label = (new DateTime.now()).format("%F");
        }
    }

    [GtkCallback]
    private void switch_page_handler (Gtk.Widget page, uint page_num)
    {
        binding_name.unbind();
        binding_type.unbind();
        binding_size.unbind();
        binding_date.unbind();
        SimpleAction? action;
        switch (page_num) {
        case 0:
            action = simple_action_group.lookup_action("show-name") as SimpleAction;
            action?.set_state (new Variant.boolean(signal_name.visible));

            action = simple_action_group.lookup_action("show-type") as SimpleAction;
            action?.set_state (new Variant.boolean(signal_type.visible));

            action = simple_action_group.lookup_action("show-size") as SimpleAction;
            action?.set_state (new Variant.boolean(signal_size.visible));

            action = simple_action_group.lookup_action("show-date") as SimpleAction;
            action?.set_state (new Variant.boolean(signal_date.visible));

            var bind_flags = BindingFlags.SYNC_CREATE | BindingFlags.BIDIRECTIONAL;
            binding_name = this.button_name.bind_property("active", this.signal_name, "visible", bind_flags);
            binding_type = this.button_type.bind_property("active", this.signal_type, "visible", bind_flags);
            binding_size = this.button_size.bind_property("active", this.signal_size, "visible", bind_flags);
            binding_date = this.button_date.bind_property("active", this.signal_date, "visible", bind_flags);
            break;
        case 1:
            action = simple_action_group.lookup_action("show-name") as SimpleAction;
            action?.set_state (new Variant.boolean(builder_name.visible));

            action = simple_action_group.lookup_action("show-type") as SimpleAction;
            action?.set_state (new Variant.boolean(builder_type.visible));

            action = simple_action_group.lookup_action("show-size") as SimpleAction;
            action?.set_state (new Variant.boolean(builder_size.visible));

            action = simple_action_group.lookup_action("show-date") as SimpleAction;
            action?.set_state (new Variant.boolean(builder_date.visible));

            var bind_flags = BindingFlags.SYNC_CREATE | BindingFlags.BIDIRECTIONAL;
            binding_name = this.button_name.bind_property("active", this.builder_name, "visible", bind_flags);
            binding_type = this.button_type.bind_property("active", this.builder_type, "visible", bind_flags);
            binding_size = this.button_size.bind_property("active", this.builder_size, "visible", bind_flags);
            binding_date = this.button_date.bind_property("active", this.builder_date, "visible", bind_flags);
            break;
        case 2:
            action = simple_action_group.lookup_action("show-name") as SimpleAction;
            action?.set_state (new Variant.boolean(mixed_name.visible));

            action = simple_action_group.lookup_action("show-type") as SimpleAction;
            action?.set_state (new Variant.boolean(mixed_type.visible));

            action = simple_action_group.lookup_action("show-size") as SimpleAction;
            action?.set_state (new Variant.boolean(mixed_size.visible));

            action = simple_action_group.lookup_action("show-date") as SimpleAction;
            action?.set_state (new Variant.boolean(mixed_date.visible));

            var bind_flags = BindingFlags.SYNC_CREATE | BindingFlags.BIDIRECTIONAL;
            binding_name = this.button_name.bind_property("active", this.mixed_name, "visible", bind_flags);
            binding_type = this.button_type.bind_property("active", this.mixed_type, "visible", bind_flags);
            binding_size = this.button_size.bind_property("active", this.mixed_size, "visible", bind_flags);
            binding_date = this.button_date.bind_property("active", this.mixed_date, "visible", bind_flags);
            break;
        case 3:
            action = simple_action_group.lookup_action("show-name") as SimpleAction;
            action?.set_state (new Variant.boolean(column_update_name.visible));

            action = simple_action_group.lookup_action("show-type") as SimpleAction;
            action?.set_state (new Variant.boolean(column_update_type.visible));

            action = simple_action_group.lookup_action("show-size") as SimpleAction;
            action?.set_state (new Variant.boolean(column_update_size.visible));

            action = simple_action_group.lookup_action("show-date") as SimpleAction;
            action?.set_state (new Variant.boolean(column_update_date.visible));

            var bind_flags = BindingFlags.SYNC_CREATE | BindingFlags.BIDIRECTIONAL;
            binding_name = this.button_name.bind_property("active", this.column_update_name, "visible", bind_flags);
            binding_type = this.button_type.bind_property("active", this.column_update_type, "visible", bind_flags);
            binding_size = this.button_size.bind_property("active", this.column_update_size, "visible", bind_flags);
            binding_date = this.button_date.bind_property("active", this.column_update_date, "visible", bind_flags);
            break;
        default:
            break;
        }
    }

    [GtkCallback]
    private void rows_mouse_click_handler(GestureClick gesture, int n_press, double x, double y)
    {
        // GLib.warning("Mouse: button = %u, n_press = %d", gesture.get_current_button(), n_press);
        if ((Gdk.BUTTON_SECONDARY == gesture.get_current_button()) && (1 == n_press))
        {
            Gtk.PopoverMenu target_menu;
            switch(books.page) {
            case 0:
                target_menu = rows_popmenu_signal;
                break;
            case 1:
                target_menu = rows_popmenu_builder;
                break;
            case 2:
                target_menu = rows_popmenu_mixed;
                break;
            case 3:
                target_menu = rows_popmenu_update;
                break;
            default:
                target_menu = rows_popmenu_signal;
                break;
            }
            Gdk.Rectangle rect = { (int)x, (int)y, 0, 0, };
            target_menu.set_pointing_to(rect);

            SelectionModel model;
            switch(books.page) {
            case 0:
                model = this.view_signal.model;
                break;
            case 1:
                model = this.view_builder.model;
                break;
            case 2:
                model = this.view_mixed.model;
                break;
            case 3:
                model = this.view_update.model;
                break;
            default:
                model = this.view_signal.model;
                break;
            }

            if (! model.get_selection().is_empty())
            {
                target_menu.popup();
            }
        } else if ((Gdk.BUTTON_PRIMARY == gesture.get_current_button()) && (2 == n_press)) {
            var message_dialog = new Gtk.MessageDialog(
                this, 
                Gtk.DialogFlags.MODAL, 
                Gtk.MessageType.INFO, 
                Gtk.ButtonsType.CLOSE,
                "Primary button double clicked.");
            message_dialog.response.connect((dialog, id) => {
                dialog.destroy();
            });
            message_dialog.secondary_text = "It's a bug if hard to fire this event.";
            message_dialog.set_default_response(ResponseType.CLOSE);
            var button = message_dialog.get_widget_for_response(ResponseType.CLOSE);
            if (null != button) {
                button.add_css_class("suggested-action");
            }
            message_dialog.show();
        }
    }

    [GtkCallback]
    private void page_close_clicked_handler(Gtk.Button sender)
    {
        int response = 0;  // ResponseType.YES / NO
        var message_dialog = new Gtk.MessageDialog(
                                                    this, 
                                                    Gtk.DialogFlags.MODAL, 
                                                    Gtk.MessageType.INFO, 
                                                    Gtk.ButtonsType.YES_NO,
                                                    "Do you want to close this page?");
        message_dialog.set_default_response(ResponseType.YES);
        var button = message_dialog.get_widget_for_response(ResponseType.YES);
        if (null != button) {
            button.add_css_class("suggested-action");
        }

        message_dialog.secondary_text = "Notebook page tab widget close button clicked, page will be close, but not in fact.";
        message_dialog.response.connect((dialog, id) => {
            response = id;
            GLib.warning("Message dialog response id(2): %d", response);
            dialog.destroy();
        });
        message_dialog.show();

        GLib.warning("Message dialog response id(1): %d", response);
}

    private void show_name_handler(SimpleAction action, Variant? parameter)
    {
        switch(books.page) {
        case 0:
            this.signal_name.visible = !signal_name.visible;
            action.set_state (new Variant.boolean(signal_name.visible));
            break;
        case 1:
            this.builder_name.visible = !builder_name.visible;
            action.set_state (new Variant.boolean(builder_name.visible));
            break;
        case 2:
            this.mixed_name.visible = !mixed_name.visible;
            action.set_state (new Variant.boolean(mixed_name.visible));
            break;
        case 3:
            this.column_update_name.visible = !column_update_name.visible;
            action.set_state (new Variant.boolean(column_update_name.visible));
            break;
        default:
            break;
        }
    }

    private void show_type_handler(SimpleAction action, Variant? parameter)
    {
        switch(books.page) {
        case 0:
            this.signal_type.visible = !signal_type.visible;
            action.set_state (new Variant.boolean(signal_type.visible));
            break;
        case 1:
            this.builder_type.visible = !builder_type.visible;
            action.set_state (new Variant.boolean(builder_type.visible));
            break;
        case 2:
            this.mixed_type.visible = !mixed_type.visible;
            action.set_state (new Variant.boolean(mixed_type.visible));
            break;
        case 3:
            this.column_update_type.visible = !column_update_type.visible;
            action.set_state (new Variant.boolean(column_update_type.visible));
            break;
        default:
            break;
        }
    }

    private void show_size_handler(SimpleAction action, Variant? parameter)
    {
        switch(books.page) {
        case 0:
            this.signal_size.visible = !signal_size.visible;
            action.set_state (new Variant.boolean(signal_size.visible));
            break;
        case 1:
            this.builder_size.visible = !builder_size.visible;
            action.set_state (new Variant.boolean(builder_size.visible));
            break;
        case 2:
            this.mixed_size.visible = !mixed_size.visible;
            action.set_state (new Variant.boolean(mixed_size.visible));
            break;
        case 3:
            this.column_update_size.visible = !column_update_size.visible;
            action.set_state (new Variant.boolean(column_update_size.visible));
            break;
        default:
            break;
        }
    }

    private void show_date_handler(SimpleAction action, Variant? parameter)
    {
        switch(books.page) {
        case 0:
            this.signal_date.visible = !signal_date.visible;
            action.set_state (new Variant.boolean(signal_date.visible));
            break;
        case 1:
            this.builder_date.visible = !builder_date.visible;
            action.set_state (new Variant.boolean(builder_date.visible));
            break;
        case 2:
            this.mixed_date.visible = !mixed_date.visible;
            action.set_state (new Variant.boolean(mixed_date.visible));
            break;
        case 3:
            this.column_update_date.visible = !column_update_date.visible;
            action.set_state (new Variant.boolean(column_update_date.visible));
            break;
        default:
            break;
        }
    }

    private void select_all_handler(SimpleAction action, Variant? parameter)
    {
        switch (books.page) {
        case 0:
            this.view_signal.model.select_all();
            break;
        case 1:
            this.view_builder.model.select_all();
            break;
        case 2:
            this.view_mixed.model.select_all();
            break;
        case 3:
            this.view_update.model.select_all();
            break;
        default:
            break;
        }
    }

    private void select_none_handler(SimpleAction action, Variant? parameter)
    {
        switch (books.page) {
        case 0:
            this.view_signal.model.unselect_all();
            break;
        case 1:
            this.view_builder.model.unselect_all();
            break;
        case 2:
            this.view_mixed.model.unselect_all();
            break;
        case 3:
            this.view_update.model.unselect_all();
            break;
        default:
            break;
        }
    }

    private void show_table_handler(SimpleAction action, Variant? parameter)
    {
        switch (books.page) {
        case 0:
            this.view_signal.add_css_class("data-table");
            this.view_signal.remove_css_class("rich-list");
            this.view_signal.remove_css_class("navigation-sidebar");
            break;
        case 1:
            this.view_builder.add_css_class("data-table");
            this.view_builder.remove_css_class("rich-list");
            this.view_builder.remove_css_class("navigation-sidebar");
            break;
        case 2:
            this.view_mixed.add_css_class("data-table");
            this.view_mixed.remove_css_class("rich-list");
            this.view_mixed.remove_css_class("navigation-sidebar");
            break;
        case 3:
            this.view_update.add_css_class("data-table");
            this.view_update.remove_css_class("rich-list");
            this.view_update.remove_css_class("navigation-sidebar");
            break;
        default:
            break;
        }

        var action2 = simple_action_group.lookup_action("show-table") as SimpleAction;
        action2?.set_state (new Variant.boolean(true));
        action2 = simple_action_group.lookup_action("show-list") as SimpleAction;
        action2?.set_state (new Variant.boolean(false));
        action2 = simple_action_group.lookup_action("show-sidebar") as SimpleAction;
        action2?.set_state (new Variant.boolean(false));
    }

    private void show_list_handler(SimpleAction action, Variant? parameter)
    {
        switch (books.page) {
        case 0:
            this.view_signal.add_css_class("rich-list");
            this.view_signal.remove_css_class("data-table");
            this.view_signal.remove_css_class("navigation-sidebar");
            break;
        case 1:
            this.view_builder.add_css_class("rich-list");
            this.view_builder.remove_css_class("data-table");
            this.view_builder.remove_css_class("navigation-sidebar");
            break;
        case 2:
            this.view_mixed.add_css_class("rich-list");
            this.view_mixed.remove_css_class("data-table");
            this.view_mixed.remove_css_class("navigation-sidebar");
            break;
        case 3:
            this.view_update.add_css_class("rich-list");
            this.view_update.remove_css_class("data-table");
            this.view_update.remove_css_class("navigation-sidebar");
            break;
        default:
            break;
        }

        var action2 = simple_action_group.lookup_action("show-table") as SimpleAction;
        action2?.set_state (new Variant.boolean(false));
        action2 = simple_action_group.lookup_action("show-list") as SimpleAction;
        action2?.set_state (new Variant.boolean(true));
        action2 = simple_action_group.lookup_action("show-sidebar") as SimpleAction;
        action2?.set_state (new Variant.boolean(false));
    }

    private void show_sidebar_handler(SimpleAction action, Variant? parameter)
    {
        switch (books.page) {
        case 0:
            this.view_signal.add_css_class("navigation-sidebar");
            this.view_signal.remove_css_class("rich-list");
            this.view_signal.remove_css_class("data-table");
            break;
        case 1:
            this.view_builder.add_css_class("navigation-sidebar");
            this.view_builder.remove_css_class("rich-list");
            this.view_builder.remove_css_class("data-table");
            break;
        case 2:
            this.view_mixed.add_css_class("navigation-sidebar");
            this.view_mixed.remove_css_class("rich-list");
            this.view_mixed.remove_css_class("data-table");
            break;
        case 3:
            this.view_update.add_css_class("navigation-sidebar");
            this.view_update.remove_css_class("rich-list");
            this.view_update.remove_css_class("data-table");
            break;
        default:
            break;
        }

        var action2 = simple_action_group.lookup_action("show-table") as SimpleAction;
        action2?.set_state (new Variant.boolean(false));
        action2 = simple_action_group.lookup_action("show-list") as SimpleAction;
        action2?.set_state (new Variant.boolean(false));
        action2 = simple_action_group.lookup_action("show-sidebar") as SimpleAction;
        action2?.set_state (new Variant.boolean(true));
    }

    [GtkCallback]
    private void column_update_name_setup_handler(Gtk.SignalListItemFactory factory, GLib.Object listitem)
    {
        Gtk.EditableLabel label = new Gtk.EditableLabel("");
        label.xalign = 0.5f;
        (listitem as Gtk.ListItem).child = label;
    }

    [GtkCallback]
    private void column_update_name_bind_handler(Gtk.SignalListItemFactory factory, GLib.Object listitem)
    {
        Gtk.ListItem list_item = listitem as Gtk.ListItem;
        Gtk.EditableLabel label = list_item.child as Gtk.EditableLabel;
        FileInfoModel? info = list_item.item as FileInfoModel;
        label.text = info?.name;
    }

    [GtkCallback]
    private void column_update_type_setup_handler(Gtk.SignalListItemFactory factory, GLib.Object listitem)
    {
        Gtk.EditableLabel label = new Gtk.EditableLabel("");
        label.xalign = 0.5f;
        (listitem as Gtk.ListItem).child = label;
    }

    [GtkCallback]
    private void column_update_type_bind_handler(Gtk.SignalListItemFactory factory, GLib.Object listitem)
    {
        Gtk.ListItem list_item = listitem as Gtk.ListItem;
        Gtk.EditableLabel label = list_item.child as Gtk.EditableLabel;
        FileInfoModel? info = list_item.item as FileInfoModel;
        label.text = info?.kind.to_string();
    }

    [GtkCallback]
    private void column_update_size_setup_handler(Gtk.SignalListItemFactory factory, GLib.Object listitem)
    {
        Gtk.EditableLabel label = new Gtk.EditableLabel("");
        label.xalign = 0.5f;
        (listitem as Gtk.ListItem).child = label;
    }

    [GtkCallback]
    private void column_update_size_bind_handler(Gtk.SignalListItemFactory factory, GLib.Object listitem)
    {
        Gtk.ListItem list_item = listitem as Gtk.ListItem;
        Gtk.EditableLabel label = list_item.child as Gtk.EditableLabel;
        FileInfoModel? info = list_item.item as FileInfoModel;
        label.text = info?.size.to_string();
    }

    [GtkCallback]
    private void column_update_date_setup_handler(Gtk.SignalListItemFactory factory, GLib.Object listitem)
    {
        Gtk.EditableLabel label = new Gtk.EditableLabel("");
        label.xalign = 0.5f;
        (listitem as Gtk.ListItem).child = label;
    }

    [GtkCallback]
    private void column_update_date_bind_handler(Gtk.SignalListItemFactory factory, GLib.Object listitem)
    {
        Gtk.ListItem list_item = listitem as Gtk.ListItem;
        Gtk.EditableLabel label = list_item.child as Gtk.EditableLabel;
        FileInfoModel? info = list_item.item as FileInfoModel;
        label.text = info?.date.format("%Y-%m-%d %H:%M:%S");
    }
}

Icon? get_icon_factory (Gtk.ListItem item, FileInfo? info) {
    if (null == info) {
        return null;
    } else {
        return info.get_icon ();
    }
}

string get_file_name_factory (Gtk.ListItem item, FileInfo? info) {
    if (null == info) {
        return "";
    } else {
        return strdup (info.get_name ());
    }
}

string get_file_type_factory (Gtk.ListItem item, FileInfo? info) {
    if (null == info) {
        return "UNKNOWN";
        // return (uint)FileType.UNKNOWN;
    } else {
        FileType type = info.get_file_type ();
        return ((EnumClass)typeof(FileType).class_ref()).get_value(type).value_name.substring(12);
        // return (uint)info.get_file_type ();
    }
}

string get_file_size_factory (Gtk.ListItem item, FileInfo? info) {
    if (null == info) {
        return "0";
    } else {
        return info.get_size().to_string();
    }
}

string get_file_date_factory (Gtk.ListItem item, FileInfo? info) {
    if (null == info) {
        return "";
    } else {
        DateTime dt = info.get_modification_date_time ();
        return dt.format("%F");
    }
}

/* Functions (closures) for GtkSorter */
string get_file_name (FileInfo? info) {
    if (null == info) {
        return "";
    } else {
        return strdup(info.get_name());
    }
}

int get_file_type (FileInfo? info) {
    if (null == info) {
        return (int)FileType.UNKNOWN;
    } else {
        return (int)info.get_file_type ();
    }
}

int64 get_file_size (FileInfo? info) {
    if (null == info) {
        return -1;
    } else {
        return info.get_size ();
    }
}

int64 get_file_date (FileInfo? info) {
    if (null == info) {
        return -1;
    } else {
        DateTime dt = info.get_modification_date_time ();
        return dt.to_unix ();
    }
}

int64 get_file_model_date (FileInfoModel? info) {
    if (null == info) {
        return -1;
    } else {
        return info.date.to_unix ();
    }
}

int get_file_model_type (FileInfoModel? info) {
    if (null == info) {
        return (int)FileType.UNKNOWN;
    } else {
        return (int)info.kind;
    }
}