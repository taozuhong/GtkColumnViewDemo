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

        { "show-table", show_table_handler },
        { "show-list", show_list_handler },
        { "show-normal", show_normal_handler },

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
        rows_right_clicked.pressed.connect(rows_right_clicked_handler);
        rows_right_clicked2.pressed.connect(rows_right_clicked_handler);
    }

    [GtkCallback]
    private void column_size_setup_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
    {
        Gtk.Label label = new Gtk.Label("");
        label.xalign = 1.0f;
        listitem.child = label;
    }

    [GtkCallback]
    private void column_size_bind_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
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
    private void column_date_setup_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
    {
        Gtk.Label label = new Gtk.Label("");
        label.xalign = 1.0f;
        listitem.child = label;
    }

    [GtkCallback]
    private void column_date_bind_handler(Gtk.SignalListItemFactory factory, Gtk.ListItem listitem)
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

    private void rows_right_clicked_handler(int n_press, double x, double y)
    {
        if (0 == books.page) {
            if (! this.columnview.model.get_selection().is_empty())
            {
                Gdk.Rectangle  rect = { (int)x, (int)y, 0, 0, };
                rows_popover_menu.set_pointing_to(rect);
                rows_popover_menu.popup();
            }
        } else {
            if (! this.columnview2.model.get_selection().is_empty())
            {
                Gdk.Rectangle  rect = { (int)x, (int)y, 0, 0, };
                rows_popover_menu2.set_pointing_to(rect);
                rows_popover_menu2.popup();
            }
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
    }

    private void show_list_handler(SimpleAction action, Variant? parameter)
    {
        if (0 == books.page) {
            this.columnview.css_classes = { "rich-list" };
        } else {
            this.columnview2.css_classes = { "rich-list" };
        }
    }

    private void show_normal_handler(SimpleAction action, Variant? parameter)
    {
        if (0 == books.page) {
            this.columnview.css_classes = { };
        } else {
            this.columnview2.css_classes = { };
        }
    }
}


Icon? get_icon_factory (Gtk.ListItem item, FileInfo? info) {
    if (null == info) {
        return null;
    } else {
        return info.get_icon ();
    }
}

string? get_file_name_factory (Gtk.ListItem item, FileInfo? info) {
    if (null == info) {
        return null;
    } else {
        return strdup (info.get_name ());
    }
}

string? get_file_type_factory (Gtk.ListItem item, FileInfo? info) {
    if (null == info) {
        return "UNKNOWN";
    } else {
        FileType type = info.get_file_type ();
        return ((EnumClass)typeof(FileType).class_ref()).get_value(type).value_name.substring(12);
    }
}

string? get_file_size_factory (Gtk.ListItem item, FileInfo? info) {
    if (null == info) {
        return null;
    } else {
        /* goffset is gint64 */
        int64 size = info.get_size ();
        return "%ld".printf ((long) size);
    }
}

string? get_file_time_modified_factory (Gtk.ListItem item, FileInfo? info) {
    if (null == info) {
        return null;
    } else {
        DateTime dt = info.get_modification_date_time ();
        return dt.format("%F");
    }
}

/* Functions (closures) for GtkSorter */
string? get_file_name (FileInfo? info) {
    if (null == info) {
        return null;
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

int64 get_file_unixtime_modified (FileInfo? info) {
    if (null == info) {
        return -1;
    } else {
        DateTime dt = info.get_modification_date_time ();
        return dt.to_unix ();
    }
}