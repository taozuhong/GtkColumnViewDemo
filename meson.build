project('GtkColumnViewDemo', ['vala', 'c'])

gtkdep = dependency('gtk4')

gnome=import('gnome')
resources = gnome.compile_resources('resources','column.gresource.xml')

# 'odbc.vapi',

sourcefiles = [
    'application.vala',
    'column.vala',
]

executable('GtkColumnViewDemo', sourcefiles, resources, dependencies: gtkdep, export_dynamic: true, install: false)
