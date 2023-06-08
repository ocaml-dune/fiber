# Unreleased

- Rename `Fiber.Pool.stop` to `Fiber.Pool.close` (#13, @rgrinberg)

- Remove `Make_map_traversals` and introduce `Make_parallel_map`. The new
  functor requires a small base API to provide a parallel map on maps and
  parallel iteration is still available via `parallel_iter_seq`. (#22,
  @rgrinberg)

# 3.7.0

- Initial release
