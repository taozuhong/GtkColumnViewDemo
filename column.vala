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

[GtkTemplate (ui = "/com/github/taozuhong/GtkColumnViewDemo/column.ui")]
public class GtkColumnViewDemoWindow : Gtk.ApplicationWindow {
    [GtkChild]
    private unowned Gtk.ColumnView columnview;
    [GtkChild]
    private unowned Gtk.DirectoryList directorylist;
    [GtkChild]
    private unowned Gtk.SortListModel sortlist;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn column_name;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn column_type;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn column_size;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn column_date;
    [GtkChild]
    private unowned Gtk.GestureClick rows_right_clicked;
    [GtkChild]
    private unowned Gtk.PopoverMenu rows_popover_menu;

    public GtkColumnViewDemoWindow(Gtk.Application app) {
        Object (application: app);
        
        File file = File.new_for_path(".");
        directorylist.set_file(file);

        sortlist.sorter = columnview.sorter;

        SimpleActionGroup actions = new SimpleActionGroup();
        
        PropertyAction action = new PropertyAction("show-name", column_name, "visible");
        actions.add_action(action);

        action = new PropertyAction("show-type", column_type, "visible");
        actions.add_action(action);

        action = new PropertyAction("show-size", column_size, "visible");
        actions.add_action(action);

        action = new PropertyAction("show-date", column_date, "visible");
        actions.add_action(action);

        this.insert_action_group("columnview", actions);

        rows_right_clicked.pressed.connect(rows_right_clicked_handler);
    }

    private void rows_right_clicked_handler(int n_press, double x, double y)
    {
        if (! this.columnview.model.get_selection().is_empty())
        {
            Gdk.Rectangle  rect = { (int)x, (int)y, 0, 0, };
            rows_popover_menu.set_pointing_to(rect);
            rows_popover_menu.popup();
        }
    }
}

public class GtkColumnViewDemoApp : Gtk.Application {
    private GtkColumnViewDemoWindow window;
    
    public GtkColumnViewDemoApp () {
        Object (application_id: "org.github.taozuhong.datagrid", flags: ApplicationFlags.HANDLES_OPEN);
    }

    protected override void activate () {
        if (this.window == null) {
            this.window = new GtkColumnViewDemoWindow (this);
        }

        window.present();
    }
}

int main (string[] args) {
    var app = new GtkColumnViewDemoApp ();
    return app.run (args);
}
