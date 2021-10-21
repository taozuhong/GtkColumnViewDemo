project('GtkColumnViewDemo', ['vala', 'c'])

gtkdep = dependency('gtk4')

gnome=import('gnome')
resources = gnome.compile_resources('resources','column.gresource.xml')

sourcefiles = [
    'column.vala',
    'application.vala'
]

executable('GtkColumnViewDemo', sourcefiles, resources, dependencies: gtkdep, export_dynamic: true, install: false)
