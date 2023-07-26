# console-type-definitions
Automated generation of Aserto console-type-definitions.

## Consuming the definitions
These definitions can be consumed by `yarn` from `npm registry` or directly from `git` using the following reference:
```
"devDependencies": {
    "@aserto/console-type-definitions": "^0.8.83",
```

Replace `0.8.83` with the version you would like to use.

## Generation Process
### Environment Variables
Generation is driven by `generate.sh`. To work with the latest specs available in `aserto-dev/openapi-grpc`, invoke `generate.sh --fetch-specs` with the following environment variables set:
 * USERNAME: GitHub username to use when authenticating with the GitHub REST API. Typically this is the value of `<vault>/kv/github/USERNAME`.
 * READ_WRITE_TOKEN: GitHub token enabling at minimum READ access to the GitHub REST API for the `aserto-dev/grpc-openapi` repo. Typically this is the value of `<vault>/kv/github/READ_WRITE_TOKEN`.
 * COMMIT_HASH: the `aserto-dev/grpc-openapi` commit for which to generate type definitions. This value is stored in `downloaded/commit_hash.sh` to enable build reproducability. That file is re-generated each time this repo's workflow is invoked by the GitHub Workflow Dispatch API.

### generate.sh
When invoked with the `--fetch-specs` flag, `generate.sh` uses the Environment Variables to download the appropriate openapi.json files into the `downloaded/specs` directory. It then runs `typescript-openapi` to generate the type definitions. If no flag is provided, then it will run `typescript-openapi` with any existing openapi.json files in `downloaded/specs`.

### Local Dev Experience
To run the script locally, set the USERNAME and READ_WRITE_TOKEN as described above and run `./generate.sh` from the workspace root directory. Because the commit_hash is checked in, the build will be identical to how it occured in the GitHub Workflow to generate this commit. To debug an older build, simply check out that commit and follow these same steps.

## GitHub Workflow
The GitHub Workflow is triggered as a workflow_dispatch. It expects to be provided with two required parameters:
- grpc_openapi_commit_hash: The `aserto-dev/grpc-openapi` commit hash for which type definitions should be created. This value is used to download the appropriate version of the `openapi.json` files from that repo.
- proto_version: The version tag of `aserto-dev/proto` that is represented by the `grpc_openapi_commit_hash`. This is used to tag the `console-type-definitions` commit with the same proto version.

Using these variables the GitHub Workflow runs the same `./generate.sh` script, commits, and tags its results for downstream consumption. Run results are deterministic as explicit commit hash and version numbers are taken as explicit input parameters.
