/**
* @name Sink identification 
* @description Sink identification 
* @kind problem
* @id go/demo/sink
* @problem.severity warning

* Identify the sink: the 3rd argument to exec.Command(...), i.e., index 2.
* Uses AST/semantic matching via resolved call target and argument position.
*/

import go

/** A sink expression corresponding to the 3rd argument to exec.Command. */
predicate isSink(Expr e) {
  exists(CallExpr c |
    c.getCalleeName() = "Command" 
    and
    e = c.getArgument(2)
  )
}

from Expr e
where isSink(e)
select e, "Sink: 3rd argument to exec.Command"

