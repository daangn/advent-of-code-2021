# OCaml π«

OCamlμ [Inria](https://www.inria.fr/en) μ°κ΅¬μμμ μ€λ«λμ κ°λ°μ€μΈ κ°λ ₯ν MLκ²μ΄ λ²μ© νλ‘κ·Έλλ° μΈμ΄μλλ€.

> OCaml: The rehabilitation clinic for OO programmers.
>
> -- [OCaml Workshop 2021 Keynote - Xavier Leroy: 25 years of OCaml](https://youtu.be/PGJdHUqgX7o)

νμ μ μΈ μΈμ΄ μ€μμλ μ€μ©μ μΈ μΈμ΄λ‘ μκΌ½νλ λͺ μλλ μΈμ΄λ‘, μ»΄νμΌλ¬, OS κ°μ μμ€ν νλ‘κ·Έλλ°μ΄λ μμ μ μΈ μΉμλ²λ₯Ό κ°λ°νλλ° μ£Όλ‘ μ¬μ©λ©λλ€.

OCamlμ κ°λ ₯ν νμ μμ€νκ³Ό λͺ¨λμμ€ν, ν¨ν΄λ§€μΉ­ λ±μ κΈ°λ₯μ F#, Scala, Rust κ°μ λ€λ₯Έ νλμ μΈ μΈμ΄λ€μ λ§μ μ§μ μ μΈ μν₯μ μ€κ²μΌλ‘ μλ €μ Έμμ΅λλ€.

## Setup

OCamlμ κ³΅μ ν¨ν€μ§ λ§€λμ μΈ [OPAM](https://opam.ocaml.org/)μ λ¨Όμ  μ€μΉν©λλ€.

```bash
# Homebrew
brew install opam

# asdf
asdf plugin add opam
## Check latest version via `asdf list all opam`
asdf install opam <version>
asdf global opam <version>
```

μ΄ νλ‘μ νΈλ OCaml νλ‘μ νΈμ© λΉλ μμ€νμΈ [dune](https://dune.readthedocs.io/en/stable/overview.html)μ μ¬μ©ν©λλ€.
duneμ΄ μ€μΉλμ΄ μλ κ²½μ° λ°λ‘ λΉλν΄λ³Ό μ μμ΅λλ€.

```bash
dune build @install
```

νμ§λ§ OCaml νλ‘μ νΈλ λ²μ  νΈνμ±μ λ€μ λ―Όκ°ν νΈμλλ€.

λ€νν OPAM Switch κΈ°λ₯μ νμ©ν΄μ νλ‘μ νΈλ₯Ό μμ²΄μ μΌλ‘ μλλ°μ± ν  μ μμ΅λλ€.

```bash
make switch
```

## Run tests

```bash
make test
```

## Run solution

```bash
# make λ¨Όμ  μ€ν
./_build/install/default/bin/aoc -d 1 -p 1 < input.txt
```
