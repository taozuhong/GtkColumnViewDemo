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