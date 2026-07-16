# SR checking for the 2026 SAT Competition

## Installation

This project requires:
- Bash.
- Python 3.11 or greater. We recommend using a standard software package manager such as `brew`, `yum`, or `apt` to install Python. Alternatively, you can download Python [here](https://www.python.org/downloads/).
- Lean 4. We recommend using the VS Code Lean extension and/or the `elan` CLI tool. You can find instructions for installing Lean [here](https://lean-lang.org/install/).

This project also depends on two `git` submodules:

- [`dsr-trim`](https://github.com/ccodel/dsr-trim), an unverified DSR and LSR checking tool.
- [`trestle`](https://github.com/FormalSAT/trestle), a Lean project for verified SAT tools and encodings.

You should see `dsr-trim` and `trestle` as two sub-folders in this project.
However, if those folders are empty on your machine, you can force `git` to download them by running:
```bash
./init.sh   # which runs the following command:
# git submodule update --init --recursive
```

## Build

Pull the code for the dependencies by running `update.sh`, then build it with `build.sh`:
```bash
./init.sh
./build.sh
```

To manually build the code, run these commands:
```bash
cd dsr-trim
make

cd trestle
lake build srcheck
```

## Check a proof

To check a proof file, use `check.sh`.
The script expects two arguments:
the path to the CNF file, and the path to the DRAT/DSR proof file.
During checking, an LSR proof file is generated,
the path of which is formed by replacing the `<drat>` file's extension with `.lsr`.
```bash
./check.sh <cnf> <drat>
```

If checking is successful, you should see an LSR proof file in the same directory as `<drat>`, and in the terminal:
```
s VERIFIED UNSAT
```

The proof is left over, so make sure to clean up afterwards, if necessary.

## Citations

Verified Substitution Redundancy Checking, at FMCAD 2024.
```
@inproceedings{srcheck2024,
  title = {Verified Substitution Redundancy Checking},
  author = {Cayden R. Codel
            and Marijn J. H. Heule
            and Jeremy Avigad},
  booktitle = {Proceedings of the 24th Conference on Formal Methods in Computer-Aided Design - {FMCAD} 2024},
  editor = {Nina Narodytska
            and Philipp R{\"u}mmer},
  year = {2024},
  volume = {5},
  series = {Formal Methods in Computer-Aided Design},
  month = {10},
  pages = {186--196},
  publisher = {TU Wien Academic Press},
  address = {Vienna, Austria},
  isbn = {978-3-85448-065-5},
  doi = {10.34727/2024/isbn.978-3-85448-065-5_24},
  url = {https://doi.org/10.34727/2024/isbn.978-3-85448-065-5_24},
}
```

## Authors

- Cayden Codel (corresponding) ([homepage](https://crcodel.com)) ([`ccodel@cs.cmu.edu`](mailto:ccodel@cs.cmu.edu))
- Marijn J. H. Heule (corresponding) ([homepage](https://www.cs.cmu.edu/~mheule/)) ([`mheule@cs.cmu.edu`](mailto:mheule@cs.cmu.edu))
- Jeremy Avigad ([homepage](https://www.andrew.cmu.edu/user/avigad/)) ([`avigad@cmu.edu`](mailto:avigad@cmu.edu))

