/**
 * Identify the sink: the 3rd argument to exec.Command(...), i.e., index 2.
 * Uses AST/semantic matching via resolved call target and argument position.
 */

import go

/** A sink expression corresponding to the 3rd argument to exec.Command. */
predicate isSink(Expr e) {
  exists(Call c, Function f |
    f = c.getTarget() and
    f.getName() = "Command" and
    f.getDeclaringPackage().getName() = "exec" and
    e = c.getArgument(2)
  )
}

from Expr e
where isSink(e)
select e, "Sink: 3rd argument to exec.Command"

