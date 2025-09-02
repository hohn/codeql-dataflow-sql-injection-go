/**
 * Identify the source: the return value of function `getUserInfo`.
 * Uses AST matching to find return expressions within that function.
 */

import go

/** A source expression corresponding to the value returned from getUserInfo. */
predicate isSource(Expr e) {
  exists(Function f, ReturnStmt r, int i |
    f.getName() = "getUserInfo" and
    r.getEnclosingFunction() = f and
    e = r.getExpr(i)
  )
}

from Expr e
where isSource(e)
select e, "Source: return value of getUserInfo"

