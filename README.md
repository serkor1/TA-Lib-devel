> [!NOTE]
>
> This repository is **not** affiliated with the upstream [TA-Lib](https://github.com/TA-Lib/ta-lib) repository.

# TA-Lib: Development Notes


## TIL (Today I Learned)

* `#include`-directives are *only* important for linking the routine with the source at compile time. The syntax highlighting and autocompletion are handled by "something else":

```json
{
  "clangd.arguments": [
    "--enable-config"
  ],
  "clangd.fallbackFlags": [
    "-I${workspaceFolder}/include",
    "-I${workspaceFolder}/lib/include",
    "-I${workspaceFolder}/lib/include/ta-lib"
  ]
}
```

Here `lib/include/*` are the built `C`-library headers. It can also be the headers defined in project itself.

* The action happens in the folders that contains the header-files and the `*.a`-, `*.so`- and `*.o`-files. Build artifacts are disposable:

```sh
make build-lib
```

Produces `build/ta-lib`, `lib/include` and `lib/lib`. It is possible to run `src/main.c` *after* deleting `build/ta-lib`.

In `R` development terms this must mean the following:

1. `build/ta-lib`: This is the built tarball that can be deleted without any issues *after* the R package have been deleted.
2. `lib/**/`: These are essentially the `Import` and `Depends` part of the `DESCRIPTION`. Delete them, and your project is basically done for.





