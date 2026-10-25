# Building and running on Linux / WSL

Builds all three programs with gfortran (tested with gfortran 14.2 on Debian 13 under WSL2):

```
cd build
make
```

* `multall` needs `-mcmodel=medium`: its common blocks are about 4 GB of static storage. Only
  a small part is touched at run time, so actual memory use is around 100 MB.
* `stagen` links against `plot_stubs.f`, no-op stand-ins for the HGRAPH plotting library it
  calls, which is not in the repo. It writes `stage_new.dat` but draws nothing.
* `fix_stagen.sed` patches `Stagen-18.1.f` before compiling. As published, the loop that
  interpolates the blade surfaces onto the output points (`DO 55`) is commented out, so
  `YSIN` is never set and every blade is written with zero camber (a flat plate in r-theta)
  without any warning. The sed script restores that loop and the trailing-edge loop
  (`DO 333`) next to it.

## Running

* `meangen` first asks whether to read from the screen or a file: answer `F` to read
  `meangen.in` in the current directory. It writes `stagen.dat`.
* The sample `meangen.in` decks are older than `meangen-17.4.f`: they lack the blockage line
  (`FBLOCK_LE, FBLOCK_TE`) it reads after the stream-surface data, so add one if a sample
  fails to read.
* `multall` reads the input format from a file called `intype` in the run directory; put `N`
  in it for the new format that `stagen` writes, then run `multall < stage_new.dat`.
* `multall` and `meangen` open `/dev/tty`, so they fail when run without a terminal (from a
  script, cron, or a batch job). Give them a pseudo-terminal with `script`:

  ```
  script -qec 'multall < stage_new.dat > multall.out 2>&1' /dev/null
  ```

  The screen output then has CRLF line endings.
