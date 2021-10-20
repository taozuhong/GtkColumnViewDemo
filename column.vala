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
    private unowned Gtk.ColumnViewColumn column_size;
    [GtkChild]
    private unowned Gtk.ColumnViewColumn column_date;
    [GtkChild]
    private unowned Gtk.GestureClick rows_right_clicked;

    Gtk.PopoverMenu datagrid_context_menu;

    public GtkColumnViewDemoWindow(Gtk.Application app) {
        Object (application: app);
        
        File file = File.new_for_path(".");
        directorylist.set_file(file);

        sortlist.sorter = columnview.sorter;

        SimpleActionGroup actions = new SimpleActionGroup();
        
        PropertyAction action = new PropertyAction("show-name", column_name, "visible");
        actions.add_action(action);

        action = new PropertyAction("show-size", column_size, "visible");
        actions.add_action(action);

        action = new PropertyAction("show-date", column_date, "visible");
        actions.add_action(action);

        this.insert_action_group("columnview", actions);

        rows_right_clicked.pressed.connect((n_press, x, y) => {
            var builder = new Gtk.Builder.from_resource("/com/github/taozuhong/GtkColumnViewDemo/column.ui");
            GLib.MenuModel context_menu = (GLib.MenuModel) builder.get_object ("header_menu");
            var datagrid_context_menu = new Gtk.PopoverMenu.from_model(context_menu);
            Gdk.Rectangle  rect = { (int)x, (int)y, 0, 0, };
            datagrid_context_menu.set_pointing_to(rect);
            datagrid_context_menu.present();
        });
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
