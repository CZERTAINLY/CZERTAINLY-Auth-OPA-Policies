# CZERTAINLY Auth OPA policies

> This repository is part of the commercial open source project CZERTAINLY. You can find more information about the project at [CZERTAINLY](https://github.com/CZERTAINLY/CZERTAINLY) repository, including the contribution guide.

This repository contains OPA policies for external evaluation of `Auth` service permissions served for [OPA](https://www.openpolicyagent.org/).

The following policies are available to evaluate permissions:

| Policy                                           | Short description                                                                                                                                                                                         |
|--------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Method policy](policies/method_policy.rego)     | Contains rules for evaluation of permissions to perform actions on resources, optionally with specified objects UUIDs                                                                                     |
| [Objects policy](policies/objects_policy.rego)   | Contains rules for evaluation of permissions for actions on resources at object level and provides a list of UUIDs for which the requested action is permitted on the resource and for which it is denied |

OPA can periodically download bundles of policies and data from remote HTTP servers. The policies and data are loaded on the fly without requiring a restart of OPA.
Once the policies and data have been loaded, they are enforced immediately.

## Input to OPA evaluation

The input data is needed for OPA policy to successfully evaluate permissions for the user and provide decision. When no input is provided, decision is denied by default.

Input data should contain at least information about the user, associated roles, requested resources to access and execute operation, and permissions.

You can find sample input here: [input.json](samples/input.json).

## Docker container

Policies in this repository can be used as a `docker` container which runs `nginx` HTTP server hosting policies acting as HTTP bundle server for OPA agent.

Use the `czertainly/czertainly-auth-opa-policies:tagname` to pull the required image from the repository.

> **Note**
> Open policy agent runs as a sidecar for the platform. It exposes the OPA policies locally and automatically synchronize policies.