package("libnbtplusplus")

set_homepage("https://github.com/PrismLauncher/libnbtplusplus")
set_description(
    "libnbt++ is a C++ library for reading, writing and manipulating Minecraft's file format Named Binary Tag (NBT).")

add_urls("https://github.com/PrismLauncher/libnbtplusplus.git")
add_versions("2.3", "531449ba1c930c98e0bcf5d332b237a8566f9d78")

add_deps("cmake", "ninja", "zlib")

on_install(function(package)
    local configs = { "-DNBT_USE_ZLIB=TRUE", "-DNBT_BUILD_TESTS=FALSE",
        "-DCMAKE_INSTALL_PREFIX=" .. package:installdir(),
        "-DNBT_DEST_DIR=" .. package:installdir()
    }
    import("package.tools.cmake").install(package, configs)
    local from_dir = path.join(package:cachedir(), "source", "libnbtplusplus", "include")
    local to_dir = package:installdir("include", "libnbtplusplus")
    os.mkdir(to_dir)
    os.cp(path.join(from_dir, "**.h"), to_dir, { rootdir = from_dir })
    local export_file_path = path.join(package:cachedir(), "source", "libnbtplusplus", "build_*", "*.h")
    for _, file in ipairs(os.files(export_file_path)) do
        os.cp(file, to_dir)
        break
    end
    os.cp(export_file_path, to_dir)
end)

package_end()
