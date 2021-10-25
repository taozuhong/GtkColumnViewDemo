public class GtkColumnViewDemoApp : Gtk.Application {
    private GtkColumnViewDemoWindow window;
    
    public GtkColumnViewDemoApp () {
        Object (application_id: "org.github.taozuhong.datagrid", flags: ApplicationFlags.HANDLES_OPEN);
    }

    const string[,] APP_ACCELS = {
        { "columnview.show-name", "<Control>1"},
        { "columnview.show-type", "<Control>2"},
        { "columnview.show-size", "<Control>3"},
        { "columnview.show-date", "<Control>4"},
        { "columnview.select-all", "<Control>A"},
        { "columnview.select-none", "<Control><Shift>A"},
        { "columnview.show-table", "<Control><Alt>T"},
        { "columnview.show-list", "<Control><Alt>L"},
        { "columnview.show-sidebar", "<Control><Alt>S"},
    };

    protected override void activate () {
        if (this.window == null) {
            this.window = new GtkColumnViewDemoWindow (this);
        }

        // Register accelerators
        string[] accel_array = {};
        for(int i = 0; i < APP_ACCELS.length[0]; i++)
        {
            accel_array = {};
            accel_array += APP_ACCELS[i,1];
            this.set_accels_for_action(APP_ACCELS[i,0], accel_array);
        }

        window.present();
    }
}

int main (string[] args) {
    var app = new GtkColumnViewDemoApp ();
    return app.run (args);
}