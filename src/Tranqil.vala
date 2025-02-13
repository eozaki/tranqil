/***

    Copyright (C) 2017 Tranqil Developers

    This program is free software: you can redistribute it and/or modify it
    under the terms of the GNU Lesser General Public License version 3, as
    published by the Free Software Foundation.

    This program is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranties of
    MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR
    PURPOSE.  See the GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program.  If not, see <http://www.gnu.org/licenses>

***/

using Gtk;

namespace Tranqil {

public class Tranqil : Gtk.Application {

    private static Tranqil app;
    private TranqilWindow window = null;
    private TranBus bus;

    public Tranqil () {
        Object (application_id: "com.enso.tranquil",
        flags: ApplicationFlags.FLAGS_NONE);
    }

    protected override void activate () {
        if (window != null) {
            window.present ();
            return;
        }

        window = new TranqilWindow (this);

        var provider = new Gtk.CssProvider ();
        provider.load_from_resource ("com/github/nick92/tranqil/ui/AppStyle.css");
        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

        //window.set_application (this);
        window.delete_event.connect(window.main_quit);
        window.show ();

        //bus = new TranBus (window.pipeline_forest);
    }

    public static Tranqil get_instance () {
        if (app == null)
            app = new Tranqil ();

        return app;
    }

    public static int main (string[] args) {
        Gst.init(ref args);
        app = new Tranqil ();

        if (args[1] == "-s") {
            return 0;
        }

        return app.run (args);
    }
  }
}
