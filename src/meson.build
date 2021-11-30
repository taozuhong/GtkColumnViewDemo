sources_vala = [
    'column.vala',
    'application.vala'
]

executable (meson.project_name(), 
            sources_vala,
            sources_resource,
            dependencies: dependencies,
            gui_app: true,
            install: true,
            install_rpath: join_paths (get_option ('prefix'), get_option ('libdir'), meson.project_name())
)