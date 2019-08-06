# aws-empty-content-encoding-issue

This illustrates issue #537 and #536 with Amazonka and S3 API.

https://github.com/brendanhay/amazonka/issues/537
https://github.com/brendanhay/amazonka/issues/536

## Installation

This should suffice to replicate issue:
1. Install Haskell Stack: `curl -sSL https://get.haskellstack.org/ | sh`
2. `git clone https://github.com/mgajda/aws-empty-content-encoding-issue.git`
3. `cd aws-empty-content-encoding-issue`
4. `stack build`
5. `stack run`

Check that metadata for the new file is `Content-Encoding: ` (empty string).
