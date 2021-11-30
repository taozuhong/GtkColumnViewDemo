project ('GtkColumnViewDemo',
         ['vala', 'c'],
         version: '1.1',
         license: 'LGPLv2+',
         meson_version: '>= 0.50.0',
)

meson_i18n = import ('i18n')
meson_gnome = import ('gnome')

dependencies = [
  dependency('gtk4', version: '>= 4.0'),
]

subdir('data')
subdir('src')
