(module
  ;; import functions passed to wasm module from js (imports have to be first) (two level namespace)
  (import "utils" "log" (func $log))
  ;; you get one param, use memory if you need more
  (import "utils" "increment" (func $increment (param i32) (result i32)))

  ;; declare memory along with size in pages (pages are 64k each)
  (memory (export "mem") 8)

  ;; call imported js log function from wasm
  (func (export "jsLoggy")
    (call $log)
  )
  ;; call imported js add function from wasm
  (func (export "jsIncrement") (param i32) (result i32)
    (call $increment (get_local 0)) ;; params can be reference by index or name
  )
  ;; add two integers
  (func (export "addy") (param $first i32) (param $second i32) (result i32)
    ;; add $first and $second and push onto stack
    (i32.add (get_local $first) (get_local $second))
  )
  ;; simple loop
  (func (export "loopIt") (param $reps i32) (result i32)
    (local $count i32)
    (set_local $count (i32.const 0))
    (set_local $reps (i32.sub (get_local $reps) (i32.const 1)))
    (block $break (loop $top
      ;; branch if
      (br_if $break (i32.eq (get_local $count) (get_local $reps)))
      (set_local $count (i32.add (get_local $count) (i32.const 1)))
      (br $top) ;; branch to block
    ))
    (get_local $count)
  )
  ;; store data to linear memory
  (func (export "pokeMem")
    (i32.store8 (i32.const 0) (i32.const 1))
  )
  ;; using an if
  (func (export "iffy") (param $zeroOrOne i32) (result i32)
    (local $result i32)
    (set_local $result (i32.const 2))
    (if (i32.eq (get_local $zeroOrOne) (i32.const 1))
      ;; if condition is met block (if param == 1)
      (set_local $result (i32.const 1))
      ;; else block
      (set_local $result (i32.const 0))
    )
    (get_local $result)
  )
  ;; if with block (run multiple commands in if)
  (func (export "ifBlock") (param $zeroOrOne i32) (result i32)
    (local $result i32)
    (set_local $result (i32.const 2))
    (if (i32.eq (get_local $zeroOrOne) (i32.const 1))
      ;; if condition is met block (if param == 1)
      (block
        (nop) ;; nop = no operation
        (set_local $result (i32.const 1))
      )
      ;; else block
      (set_local $result (i32.const 0))
    )
    (get_local $result)
  )
  ;; & two integers
  (func (export "andy") (param $one i32) (param $two i32) (result i32)
    (i32.and (get_local $one) (get_local $two))
  )
  ;; greater than or equal to
  (func (export "greaterThanEqual") (param $one i32) (param $two i32) (result i32)
    (local $result i32)
    (set_local $result (i32.const 0))
    (if (i32.ge_u (get_local $one) (get_local $two))
      (set_local $result (i32.const 1))
    )
    (get_local $result)
  )
)
