(module
  ;; declare memory along with size in pages (pages are 64k each)
  (memory (export "mem") 8)
  ;; add two integers
  (func (export "addy") (param $foo i32) (param $bar i32) (result i32)
    (i32.add (get_local $foo) (get_local $bar))
  )
  ;; simple loop
  (func (export "loopIt") (param $reps i32) (result i32)
    (local $count i32)
    (set_local $count (i32.const 0))
    (set_local $reps (i32.sub (get_local $reps) (i32.const 1)))
    (block $break (loop $top
      (br_if $break (i32.eq (get_local $count) (get_local $reps)))
      (set_local $count (i32.add (get_local $count) (i32.const 1)))
      (br $top)
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
      ;; if condition is met block
      (set_local $result (i32.const 1))
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
