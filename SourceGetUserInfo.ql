/**
 * Identify the source: the return value of function `getUserInfo`.
 * Uses AST matching to find return expressions within that function.
 */

import go
import DataFlow as DF

from DF::CallNode cn
where cn.getACalleeIncludingExternals().getName() = "ReadString"
select cn
