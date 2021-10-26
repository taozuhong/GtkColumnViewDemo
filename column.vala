using Gtk;

[GtkTemplate (ui = "/com/github/taozuhong/GtkColumnViewDemo/column.ui")]
public class GtkColumnViewDemoWindow : Gtk.ApplicationWindow {
    [GtkChild]
    private unowned Gtk.Notebook books;
    [GtkChild]
    private unowned Gtk.ColumnView columnview;
    [GtkChild]
    private unowned Gtk.ColumnView columnview2;
    [GtkChild]
    private unowned Gtk.DirectoryList directorylist;
    [GtkChild]
    private unowned Gtk.DirectoryList directorylist2;
    [GtkChild]
    private unowned Gtk.SortListModel sortlist;
    [GtkChild]
    private unowned Gtk.SortListModel sortlist2;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn column_name;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn column_type;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn column_size;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn column_date;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn column_name2;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn column_type2;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn column_size2;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn column_date2;
    [GtkChild]
    private unowned Gtk.GestureClick rows_right_clicked;
    [GtkChild]
    private unowned Gtk.GestureClick rows_right_clicked2;
    [GtkChild]
    private unowned Gtk.PopoverMenu rows_popover_menu;
    [GtkChild]
    private unowned Gtk.PopoverMenu rows_popover_menu2;

    private SimpleActionGroup simple_action_group;

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

        sortlist.sorter = columnview.sorter;
        sortlist2.sorter = columnview2.sorter;

        simple_action_group = new SimpleActionGroup();
        simple_action_group.add_action_entries(action_entries, this);
        this.insert_action_group("columnview", simple_action_group);

        this.books.switch_page.connect(switch_page_handler);
        rows_right_clicked.pressed.connect(rows_mouse_click_handler);
        rows_right_clicked2.pressed.connect(rows_mouse_click_handler);
    }

    [GtkCallback]
    private void column_name_setup_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
    {
        Gtk.EditableLabel label = new Gtk.EditableLabel("");
        label.xalign = 0.5f;
        listitem.child = label;
    }

    [GtkCallback]
    private void column_name_bind_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
    {
        Gtk.EditableLabel label = listitem.child as Gtk.EditableLabel;
        FileInfo? info = listitem.item as FileInfo;
        if (null != info) {
            label.text = info.get_name();
        } else {
            label.text = "NULL";
        }
    }

    [GtkCallback]
    private void column_type_setup_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
    {
        string[] type_array = { "UNKNOWN", "REGULAR", "DIRECTORY", "SYMBOLIC_LINK", "SPECIAL", "SHORTCUT", "MOUNTABLE" };
        Gtk.ComboBoxText dropdown = new Gtk.ComboBoxText.with_entry();
        foreach(var text in type_array) {
            dropdown.append_text(text);
        }
        listitem.child = dropdown;
    }

    [GtkCallback]
    private void column_type_bind_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
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
    private void column_size_setup_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
    {
        Gtk.Adjustment adjustment = new Gtk.Adjustment(0, 0, 1000000, 1, 10, 0);
        Gtk.SpinButton spin_button = new Gtk.SpinButton(adjustment, 1.0, 2);
        listitem.child = spin_button;
    }

    [GtkCallback]
    private void column_size_bind_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
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
    private void column_date_setup_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
    {
        Gtk.Popover popover = new Gtk.Popover();
        Gtk.MenuButton button = new Gtk.MenuButton();
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
    private void column_date_bind_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
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

    [GtkCallback]
    private void column_size2_setup_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
    {
        Gtk.Label label = new Gtk.Label("");
        label.xalign = 1.0f;
        listitem.child = label;
    }

    [GtkCallback]
    private void column_size2_bind_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
    {
        Gtk.Label label = listitem.child as Gtk.Label;
        FileInfo? info = listitem.item as FileInfo;
        if (null != info) {
            label.label = "%ld".printf((long)info.get_size());;
        } else {
            label.label = "NULL";
        }
    }

    [GtkCallback]
    private void column_date2_setup_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
    {
        Gtk.Label label = new Gtk.Label("");
        label.xalign = 1.0f;
        listitem.child = label;
    }

    [GtkCallback]
    private void column_date2_bind_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
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

    private void switch_page_handler (Gtk.Widget page, uint page_num)
    {
        SimpleAction? action;
        if (0 == page_num)
        {
            action = simple_action_group.lookup_action("show-name") as SimpleAction;
            action?.set_state (new Variant.boolean(column_name.visible));

            action = simple_action_group.lookup_action("show-type") as SimpleAction;
            action?.set_state (new Variant.boolean(column_type.visible));

            action = simple_action_group.lookup_action("show-size") as SimpleAction;
            action?.set_state (new Variant.boolean(column_size.visible));

            action = simple_action_group.lookup_action("show-date") as SimpleAction;
            action?.set_state (new Variant.boolean(column_date.visible));
        } else {
            action = simple_action_group.lookup_action("show-name") as SimpleAction;
            action?.set_state (new Variant.boolean(column_name2.visible));

            action = simple_action_group.lookup_action("show-type") as SimpleAction;
            action?.set_state (new Variant.boolean(column_type2.visible));

            action = simple_action_group.lookup_action("show-size") as SimpleAction;
            action?.set_state (new Variant.boolean(column_size2.visible));

            action = simple_action_group.lookup_action("show-date") as SimpleAction;
            action?.set_state (new Variant.boolean(column_date2.visible));
        }
    }

    private void rows_mouse_click_handler(GestureClick gesture, int n_press, double x, double y)
    {
        // GLib.warning("Mouse: button = %u, n_press = %d", gesture.get_current_button(), n_press);
        if ((Gdk.BUTTON_SECONDARY == gesture.get_current_button()) && (1 == n_press))
        {
            Gtk.PopoverMenu target_menu = (0 == books.page) ? rows_popover_menu : rows_popover_menu2;
            Gdk.Rectangle rect = { (int)x, (int)y, 0, 0, };
            target_menu.set_pointing_to(rect);

            SelectionModel model = (0 == books.page) ? this.columnview.model : this.columnview2.model;
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
                "Double clicked.");
            message_dialog.response.connect((dialog, id) => {
                dialog.destroy();
            });
            message_dialog.show();
        }
    }

    private void show_name_handler(SimpleAction action, Variant? parameter)
    {
        if (0 == books.page) {
            this.column_name.visible = !column_name.visible;
            action.set_state (new Variant.boolean(column_name.visible));
        } else {
            this.column_name2.visible = !column_name2.visible;
            action.set_state (new Variant.boolean(column_name2.visible));
        }
    }

    private void show_type_handler(SimpleAction action, Variant? parameter)
    {
        if (0 == books.page) {
            this.column_type.visible = !column_type.visible;
            action.set_state (new Variant.boolean(column_type.visible));
        } else {
            this.column_type2.visible = !column_type2.visible;
            action.set_state (new Variant.boolean(column_type2.visible));
        }
    }

    private void show_size_handler(SimpleAction action, Variant? parameter)
    {
        if (0 == books.page) {
            this.column_size.visible = !column_size.visible;
            action.set_state (new Variant.boolean(column_size.visible));
        } else {
            this.column_size2.visible = !column_size2.visible;
            action.set_state (new Variant.boolean(column_size2.visible));
        }
    }

    private void show_date_handler(SimpleAction action, Variant? parameter)
    {
        if (0 == books.page) {
            this.column_date.visible = !column_date.visible;
            action.set_state (new Variant.boolean(column_date.visible));
        } else {
            this.column_date2.visible = !column_date2.visible;
            action.set_state (new Variant.boolean(column_date2.visible));
        }
    }

    private void select_all_handler(SimpleAction action, Variant? parameter)
    {
        if (0 == books.page) {
            this.columnview.model.select_all();
        } else {
            this.columnview2.model.select_all();
        }
    }

    private void select_none_handler(SimpleAction action, Variant? parameter)
    {
        if (0 == books.page) {
            this.columnview.model.unselect_all();
        } else {
            this.columnview2.model.unselect_all();
        }
    }

    private void show_table_handler(SimpleAction action, Variant? parameter)
    {
        if (0 == books.page) {
            this.columnview.css_classes = { "data-table" };
        } else {
            this.columnview2.css_classes = { "data-table" };
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
            this.columnview.css_classes = { "rich-list" };
        } else {
            this.columnview2.css_classes = { "rich-list" };
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
            this.columnview.css_classes = { "navigation-sidebar" };
        } else {
            this.columnview2.css_classes = { "navigation-sidebar" };
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

double get_file_size_factory (Gtk.ListItem item, FileInfo? info) {
    if (null == info) {
        return 0.0;
    } else {
        /* goffset is gint64 */
        // int64 size = (double)info.get_size ();
        // return "%ld".printf ((long) size);
        return (double)info.get_size();
    }
}

string get_file_time_modified_factory (Gtk.ListItem item, FileInfo? info) {
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