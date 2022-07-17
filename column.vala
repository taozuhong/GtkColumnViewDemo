using Gtk;

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
    private unowned Gtk.DirectoryList directorylist;
    [GtkChild]
    private unowned Gtk.DirectoryList directorylist2;
    [GtkChild]
    private unowned Gtk.SortListModel sortlist;
    [GtkChild]
    private unowned Gtk.SortListModel sortlist2;
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
    private unowned Gtk.GestureClick rows_right_clicked;
    [GtkChild]
    private unowned Gtk.GestureClick rows_right_clicked2;
    [GtkChild]
    private unowned Gtk.PopoverMenu rows_popover_menu;
    [GtkChild]
    private unowned Gtk.PopoverMenu rows_popover_menu2;

    private SimpleActionGroup simple_action_group;
    private unowned Binding binding_name;
    private unowned Binding binding_type;
    private unowned Binding binding_size;
    private unowned Binding binding_date;

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
        
        File file = File.new_for_path(".");
        directorylist.set_file(file);
        directorylist2.set_file(file);

        sortlist.sorter = view_signal.sorter;
        sortlist2.sorter = view_builder.sorter;

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
    private void signal_name_setup_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
    {
        Gtk.Entry entry = new Gtk.Entry();
        entry.focusable = true;
        entry.secondary_icon_name = "accessories-text-editor";
        entry.secondary_icon_activatable = true;
        entry.secondary_icon_tooltip_text = "Click icon to edit it in large window";
        entry.xalign = 0.5f;
        listitem.child = entry;
    }

    [GtkCallback]
    private void signal_name_bind_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
    {
        Gtk.Entry entry = listitem.child as Gtk.Entry;
        FileInfo? info = listitem.item as FileInfo;
        if (null != info) {
            entry.text = info.get_name();
        } else {
            entry.text = "NULL";
        }
    }

    [GtkCallback]
    private void signal_type_setup_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
    {
        string[] type_array = { "UNKNOWN", "REGULAR", "DIRECTORY", "SYMBOLIC_LINK", "SPECIAL", "SHORTCUT", "MOUNTABLE" };
        Gtk.ComboBoxText dropdown = new Gtk.ComboBoxText.with_entry();
        dropdown.focusable = true;
        dropdown.has_frame = true;
        foreach(var text in type_array) {
            dropdown.append_text(text);
        }
        listitem.child = dropdown;
    }

    [GtkCallback]
    private void signal_type_bind_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
    {
        Gtk.ComboBoxText dropdown = listitem.child as Gtk.ComboBoxText;
        FileInfo? info = listitem.item as FileInfo;
        if (null != info) {
            dropdown.active = info.get_file_type();
        } else {
            dropdown.active = FileType.UNKNOWN;
        }
    }

    [GtkCallback]
    private void signal_size_setup_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
    {
        Gtk.Adjustment adjustment = new Gtk.Adjustment(0, 0, 1000000, 1, 10, 0);
        Gtk.SpinButton spin_button = new Gtk.SpinButton(adjustment, 1.0, 2);
        spin_button.focusable = true;
        spin_button.css_classes = { "vertical" };
        listitem.child = spin_button;
    }

    [GtkCallback]
    private void signal_size_bind_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
    {
        Gtk.SpinButton spin_button = listitem.child as Gtk.SpinButton;
        FileInfo? info = listitem.item as FileInfo;
        if (null != info) {
            spin_button.value = (double)info.get_size();
        } else {
            spin_button.value = 0.0;
        }
    }

    [GtkCallback]
    private void signal_date_setup_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
    {
        Gtk.Popover popover = new Gtk.Popover();
        Gtk.MenuButton button = new Gtk.MenuButton();
        button.focusable = true;
        button.popover = popover;
        listitem.child = button;

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
    private void signal_date_bind_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
    {
        Gtk.MenuButton button = listitem.child as Gtk.MenuButton;
        FileInfo? info = listitem.item as FileInfo;
        if (null != info) {
            DateTime datetime = info.get_modification_date_time ();
            button.label = datetime.format("%F");
        } else {
            button.label = (new DateTime.now()).format("%F");
        }
    }

    //[GtkCallback]
    private void builder_size_setup_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
    {
        Gtk.Label label = new Gtk.Label("");
        label.xalign = 1.0f;
        listitem.child = label;
    }

    //[GtkCallback]
    private void builder_size_bind_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
    {
        Gtk.Label label = listitem.child as Gtk.Label;
        FileInfo? info = listitem.item as FileInfo;
        if (null != info) {
            label.label = "%ld".printf((long)info.get_size());;
        } else {
            label.label = "NULL";
        }
    }

    //[GtkCallback]
    private void builder_date_setup_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
    {
        Gtk.Label label = new Gtk.Label("");
        label.xalign = 1.0f;
        listitem.child = label;
    }

    //[GtkCallback]
    private void builder_date_bind_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
    {
        Gtk.Label label = listitem.child as Gtk.Label;
        FileInfo? info = listitem.item as FileInfo;
        if (null != info) {
            DateTime dt = info.get_modification_date_time ();
            label.label = dt.format("%F");
        } else {
            label.label = "NULL";
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
        if (0 == page_num)
        {
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
        } else {
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
        }
    }

    [GtkCallback]
    private void rows_mouse_click_handler(GestureClick gesture, int n_press, double x, double y)
    {
        // GLib.warning("Mouse: button = %u, n_press = %d", gesture.get_current_button(), n_press);
        if ((Gdk.BUTTON_SECONDARY == gesture.get_current_button()) && (1 == n_press))
        {
            Gtk.PopoverMenu target_menu = (0 == books.page) ? rows_popover_menu : rows_popover_menu2;
            Gdk.Rectangle rect = { (int)x, (int)y, 0, 0, };
            target_menu.set_pointing_to(rect);

            SelectionModel model = (0 == books.page) ? this.view_signal.model : this.view_builder.model;
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
        if (0 == books.page) {
            this.signal_name.visible = !signal_name.visible;
            action.set_state (new Variant.boolean(signal_name.visible));
        } else {
            this.builder_name.visible = !builder_name.visible;
            action.set_state (new Variant.boolean(builder_name.visible));
        }
    }

    private void show_type_handler(SimpleAction action, Variant? parameter)
    {
        if (0 == books.page) {
            this.signal_type.visible = !signal_type.visible;
            action.set_state (new Variant.boolean(signal_type.visible));
        } else {
            this.builder_type.visible = !builder_type.visible;
            action.set_state (new Variant.boolean(builder_type.visible));
        }
    }

    private void show_size_handler(SimpleAction action, Variant? parameter)
    {
        if (0 == books.page) {
            this.signal_size.visible = !signal_size.visible;
            action.set_state (new Variant.boolean(signal_size.visible));
        } else {
            this.builder_size.visible = !builder_size.visible;
            action.set_state (new Variant.boolean(builder_size.visible));
        }
    }

    private void show_date_handler(SimpleAction action, Variant? parameter)
    {
        if (0 == books.page) {
            this.signal_date.visible = !signal_date.visible;
            action.set_state (new Variant.boolean(signal_date.visible));
        } else {
            this.builder_date.visible = !builder_date.visible;
            action.set_state (new Variant.boolean(builder_date.visible));
        }
    }

    private void select_all_handler(SimpleAction action, Variant? parameter)
    {
        if (0 == books.page) {
            this.view_signal.model.select_all();
        } else {
            this.view_builder.model.select_all();
        }
    }

    private void select_none_handler(SimpleAction action, Variant? parameter)
    {
        if (0 == books.page) {
            this.view_signal.model.unselect_all();
        } else {
            this.view_builder.model.unselect_all();
        }
    }

    private void show_table_handler(SimpleAction action, Variant? parameter)
    {
        if (0 == books.page) {
            this.view_signal.css_classes = { "data-table" };
        } else {
            this.view_builder.css_classes = { "data-table" };
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
        if (0 == books.page) {
            this.view_signal.css_classes = { "rich-list" };
        } else {
            this.view_builder.css_classes = { "rich-list" };
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
        if (0 == books.page) {
            this.view_signal.css_classes = { "navigation-sidebar" };
        } else {
            this.view_builder.css_classes = { "navigation-sidebar" };
        }

        var action2 = simple_action_group.lookup_action("show-table") as SimpleAction;
        action2?.set_state (new Variant.boolean(false));
        action2 = simple_action_group.lookup_action("show-list") as SimpleAction;
        action2?.set_state (new Variant.boolean(false));
        action2 = simple_action_group.lookup_action("show-sidebar") as SimpleAction;
        action2?.set_state (new Variant.boolean(true));
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

uint get_file_type (FileInfo? info) {
    if (null == info) {
        return (uint)FileType.UNKNOWN;
    } else {
        return (uint)info.get_file_type ();
    }
}

int64 get_file_size (FileInfo? info) {
    if (null == info) {
        return -1;
    } else {
        return info.get_size ();
    }
}

int64 get_file_unixtime_modified (FileInfo? info) {
    if (null == info) {
        return -1;
    } else {
        DateTime dt = info.get_modification_date_time ();
        return dt.to_unix ();
    }
}