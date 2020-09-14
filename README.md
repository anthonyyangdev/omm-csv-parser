# Parse OMM CSV

> A csv filter tool for the OMM csv downloaded from Canvas for CS 3110 TAs and sections.

## Requirements

In the spirit of CS3110, this project was written in OCaml and thus requires
OCaml to build the executable. However, a transpiled Node.js version and
a compressed version of that is also available in the `node` directory in
case OCaml is not obtainable.

### For OCaml users

This will assume that you've already installed opam and configured it for your machine.
You will also need Python3 to run the `setup.py` file.

```sh
opam install dune csv # js_of_ocaml (* not required unless you want to transpile the OCaml code to JS. *)
```

### For Node users

You will need to install Node of version at least 12.

## Installation for OCaml users

The Makefile contains a script to copy the executable into the /usr/local/bin
directory on Posix machines or the C:\\Windows\\System32\\ folder on Windows.

```sh
make exe_path
```

## Usage of Executable or Node

```sh
omm [csv_file] -s [section_number] -o [output_filename]

# Without output
omm [csv_file] -s [section_number]

# -i flag can also be used for input
omm -s [section_number] -i [csv_file]
```

For Node, the usage is essentially the same, only using the transpiled JS file
and in the Node runtime environment.

```sh
node omm.js [csv_file] -s [section_number] -o [output_filename]

# Without output
node omm.js [csv_file] -s [section_number]

# -i flag can also be used for input
node omm.js -s [section_number] -i [csv_file]
```

## Other Usages

```sh
# Remove generated files from the Makefile.
make clean

# Generates the node scripts
make node

# Generates the executable using dune.
make exe
```

## License

MIT © [Anthony Yang]()
