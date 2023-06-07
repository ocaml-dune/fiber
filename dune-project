(lang dune 3.6)

(name fiber)

(generate_opam_files true)

(license MIT)
(maintainers "Jane Street Group, LLC <opensource@janestreet.com>")
(authors "Jane Street Group, LLC <opensource@janestreet.com>")
(source (github ocaml-dune/fiber))

(implicit_transitive_deps false)

(package
 (name fiber)
 (synopsis "Dune's monadic structured concurrency library")
 (depends
  (ocaml (>= 4.08))
  (ppx_expect :with-test)
  dyn
  stdune))

(package
 (name fiber-lwt)
 (synopsis "Compatibility layer for fibers inside Lwt")
 (depends
  (ocaml (>= 4.08))
  lwt
  stdune
  fiber))
