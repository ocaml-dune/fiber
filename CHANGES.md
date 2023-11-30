# Unreleased

- Make [Fiber.both] concurrent (#32, @rgrinberg)

- Add [Fiber.Lazy] (#36, #rleshchinskiy)

- Rename `Fiber.Pool.stop` to `Fiber.Pool.close` (#13, @rgrinberg)

- Remove `Make_map_traversals` and introduce `Make_parallel_map`. The new
  functor requires a small base API to provide a parallel map on maps and
  parallel iteration is still available via `parallel_iter_seq`. (#22,
  @rgrinberg)

- Remove `Nonempty_list` from the scheduler API. It's replaced with a regular
  list and there's no issues with providing an empty list (#19, @rgrinberg)

# 3.7.0

- Initial release
