# OCaml 🐫

OCaml은 [Inria](https://www.inria.fr/en) 연구소에서 오랫동안 개발중인 강력한 ML게열 범용 프로그래밍 언어입니다.

> OCaml: The rehabilitation clinic for OO programmers.
>
> -- [OCaml Workshop 2021 Keynote - Xavier Leroy: 25 years of OCaml](https://youtu.be/PGJdHUqgX7o)

학술적인 언어 중에서도 실용적인 언어로 손꼽히는 몇 안되는 언어로, 컴파일러, OS 같은 시스템 프로그래밍이나 안정적인 웹서버를 개발하는데 주로 사용됩니다.

OCaml의 강력한 타입 시스템과 모듈시스템, 패턴매칭 등의 기능은 F#, Scala, Rust 같은 다른 현대적인 언어들에 많은 직접적인 영향을 준것으로 알려져있습니다.

## Setup

OCaml의 공식 패키지 매니저인 [OPAM](https://opam.ocaml.org/)을 먼저 설치합니다.

```bash
# Homebrew
brew install opam

# asdf
asdf plugin add opam
## Check latest version via `asdf list all opam`
asdf install opam <version>
asdf global opam <version>
```

이 프로젝트는 OCaml 프로젝트용 빌드 시스템인 [dune](https://dune.readthedocs.io/en/stable/overview.html)을 사용합니다.
dune이 설치되어 있는 경우 바로 빌드해볼 수 있습니다.

```bash
dune build @install
```

하지만 OCaml 프로젝트는 버전 호환성에 다소 민감한 편입니다.

다행히 OPAM Switch 기능을 활용해서 프로젝트를 자체적으로 샌드박싱 할 수 있습니다.

```bash
make switch
```

## Run tests

```bash
make test
```

## Run solution

```bash
# make 먼저 실행
./_build/install/default/bin/aoc -d 1 -p 1 < input.txt
```
