open Stdune
open Fiber.O

let printf = Printf.printf
let print_dyn dyn = Dyn.to_string dyn |> print_endline
let () = Printexc.record_backtrace false

module Scheduler = struct
  let t = Test_scheduler.create ()
  let yield () = Test_scheduler.yield t
  let run f = Test_scheduler.run t f
end

let%expect_test "map_reduce_seq" =
  let test =
    let+ res =
      Fiber.map_reduce_seq
        (List.to_seq [ 1; 2; 3 ])
        ~f:(fun x ->
          printfn "x: %d" x;
          Fiber.return x)
        ~empty:0
        ~commutative_combine:( + )
    in
    printfn "final: %d" res
  in
  Scheduler.run test;
  [%expect {|
    x: 1
    x: 2
    x: 3
    final: 6 |}];
  let test =
    let ivars = List.init 3 ~f:(fun _ -> Fiber.Ivar.create ()) in
    Fiber.fork_and_join_unit
      (fun () ->
        let+ res =
          Fiber.map_reduce_seq
            (List.to_seq ivars)
            ~f:(fun ivar ->
              let+ x = Fiber.Ivar.read ivar in
              printfn "x: %d" x;
              x)
            ~empty:0
            ~commutative_combine:( + )
        in
        printfn "final: %d" res)
      (fun () ->
        let i = ref 0 in
        Fiber.parallel_iter ivars ~f:(fun ivar ->
          incr i;
          printfn "filling ivar %d" !i;
          Fiber.Ivar.fill ivar !i))
  in
  Scheduler.run test;
  [%expect
    {|
    filling ivar 1
    filling ivar 2
    filling ivar 3
    x: 1
    x: 2
    x: 3
    final: 6 |}]
;;
