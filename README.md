# CZERTAINLY Auth OPA policies

> This repository is part of the commercial open source project CZERTAINLY. You can find more information about the project at [CZERTAINLY](https://github.com/3KeyCompany/CZERTAINLY) repository, including the contribution guide.

This repository contains OPA policies for external evaluation of `Auth` service permissions served for [OPA](https://www.openpolicyagent.org/).
Currently there are 3 policies which evaluate permissions in CZERTAINLY platform:
- *Endpoint policy* - contains rules for evaluation of specific cases of authorizing access to endpoint (e.g. access from localhost)
- *Method policy* - contains rules for evaluation of permissions to perform action on resource, optionally with specified objects UUIDs
- *Objects policy* - contains rules for evaluation of permissions for action on resource at object level and provides a list of UUIDs for which the requested action is permitted on the resource and for which it is denied. It is used for filtering listing of resource objects.

OPA can periodically download bundles of policy and data from remote HTTP servers. The policies and data are loaded on the fly without requiring a restart of OPA.
Once the policies and data have been loaded, they are enforced immediately.

Therefore, policies in this repository can be used as a Docker container which runs NGINX HTTP server hosting policies acting as HTTP bundle server for OPA agent running as separate container (e.g. sidecar).

## Docker container

Use the `3keycompany/czertainly-auth-opa-policies:tagname` to pull the required image from the repository.