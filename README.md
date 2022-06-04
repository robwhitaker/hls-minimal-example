# hls-minimal-example

## Dev environment

With nix flakes setup, `nix develop`.

## Issue

HLS seems to disregard flags provided in the `ghc-options` field of the cabal file.

## Example

With the flags in this project (`-Wall` and `-Werror`), the incomplete case statement in `src/Main.hs` should be reported as a compiler error.

With `cabal build`, a compiler error is indeed reported:

```
$ cabal build
Build profile: -w ghc-9.2.2 -O1
In order, the following will be built (use -v for more details):
 - hls-minimal-example-0.0.0.0 (exe:example) (first run)
Preprocessing executable 'example' for hls-minimal-example-0.0.0.0..
Building executable 'example' for hls-minimal-example-0.0.0.0..
[1 of 1] Compiling Main             ( src/Main.hs, /home/rhit/projects/hls-minimal-example/dist-newstyle/build/x86_64-linux/ghc-9.2.2/hls-minimal-example-0.0.0.0/x/example/build/example/example-tmp/Main.o )

src/Main.hs:9:3: error: [-Wincomplete-patterns, -Werror=incomplete-patterns]
    Pattern match(es) are non-exhaustive
    In a case alternative:
        Patterns of type ‘Maybe Int’ not matched: Just _
  |
9 |   case readMaybe @Int "incomplete case" of
  |   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^...
```

But HLS only reports this as a warning:

```
$ haskell-language-server-wrapper typecheck
...
- file diagnostics: File:     /home/rhit/projects/hls-minimal-example/src/Main.hs
Hidden:   no
Range:    9:3-10:47
Source:   compile
Severity: DsWarning
Message:
  Pattern match(es) are non-exhaustive
  In a case alternative:
  Patterns of type ‘Maybe Int’ not matched: Just _

Completed (1 file worked, 0 files failed)
```
