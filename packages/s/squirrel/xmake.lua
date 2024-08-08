package("squirrel")
    set_homepage("http://www.squirrel-lang.org")
    set_description("Official repository for the programming language Squirrel")
    set_license("MIT")

    add_urls("https://github.com/albertodemichelis/squirrel/archive/refs/tags/$(version).tar.gz",
             "https://github.com/albertodemichelis/squirrel.git")

    add_versions("v3.2", "02805414cfadd5bbb921891d3599b83375a40650abd6404a8ab407dc5e86a996")

    add_deps("cmake")

    on_install(function (package)
        local configs = {}
        table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:is_debug() and "Debug" or "Release"))
        table.insert(configs, "-DBUILD_SHARED_LIBS=" .. (package:config("shared") and "ON" or "OFF"))
        import("package.tools.cmake").install(package, configs)
    end)

    on_test(function (package)
        assert(package:has_cfuncs("sq_open", {includes = "squirrel.h"}))
    end)
