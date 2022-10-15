# CZERTAINLY Auth OPA policies

> This repository is part of the commercial open source project CZERTAINLY. You can find more information about the project at [CZERTAINLY](https://github.com/3KeyCompany/CZERTAINLY) repository, including the contribution guide.

This repository contains OPA policies for external evaluation of `Auth` service permissions served for [OPA](https://www.openpolicyagent.org/).

The following policies are available to evaluate permissions:

| Policy                                           | Short description                                                                                                                                                                                         |
|--------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Endpoint policy](policies/endpoint_policy.rego) | Contains rules for evaluation of specific cases of authorizing access to endpoints (e.g. access from localhost)                                                                                           |
| [Method policy](policies/method_policy.rego)     | Contains rules for evaluation of permissions to perform actions on resources, optionally with specified objects UUIDs                                                                                     |
| [Objects policy](policies/objects_policy.rego)   | Contains rules for evaluation of permissions for actions on resources at object level and provides a list of UUIDs for which the requested action is permitted on the resource and for which it is denied |

OPA can periodically download bundles of policies and data from remote HTTP servers. The policies and data are loaded on the fly without requiring a restart of OPA.
Once the policies and data have been loaded, they are enforced immediately.

### OPA permission evaluation input

When permissions need to be checked, part of request to OPA and its specified policy is following input data. Based on input data, policy generates its decision and allow or deny access for the request.   
```json
{
  "input":
  {
    "details": {},
    "principal": {
      "roles": [
        "test-role"
      ],
      "user": {
        "createdAt": "2022-10-14T21:51:26.995274+00:00",
        "description": null,
        "email": "test@test.com",
        "enabled": true,
        "firstName": "Test",
        "lastName": "Test",
        "systemUser": false,
        "updatedAt": "2022-10-14T21:51:26.995318+00:00",
        "username": "test",
        "uuid": "8fbd0d41-03af-4376-b2f6-0abc44c37364"
      },
      "requestedResource": {
        "action": "detail",
        "name": "raProfiles",
        "uuids": [
          "d7d5b6e6-0335-4492-a994-6120751fced1"
        ]
      },
      "permissions": {
        "allowAllResources": false,
        "resources": [
          {
            "name": "authorities",
            "allowAllActions": false,
            "actions": [],
            "objects": [
              {
                "name": "EJBCA-NG-Authority",
                "uuid": "279547ae-62b1-4141-8aa1-a579eb343b74",
                "allow": [
                  "list",
                  "detail"
                ],
                "deny": []
              }
            ]
          },
          {
            "name": "certificates",
            "allowAllActions": true,
            "actions": [],
            "objects": []
          },
          {
            "name": "raProfiles",
            "allowAllActions": false,
            "actions": [
              "detail",
              "list"
            ],
            "objects": [
              {
                "name": "NG-RA-Profile1",
                "uuid": "d7d5b6e6-0335-4492-a994-6120751fced1",
                "allow": [],
                "deny": [
                  "delete"
                ]
              }
            ]
          }
        ]
      }
    }
  }
}
```

## Docker container

Policies in this repository can be used as a `docker` container which runs `nginx` HTTP server hosting policies acting as HTTP bundle server for OPA agent.

Use the `3keycompany/czertainly-auth-opa-policies:tagname` to pull the required image from the repository.

> **Note**
> Open policy agent runs as a sidecar for the platform. It exposes the OPA policies locally and automatically synchronize policies.