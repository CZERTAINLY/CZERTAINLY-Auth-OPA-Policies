package endpoint

authorized = true {
	count(allow) > 0
}

# Allow access to the endpoint if the request comes from the localhost
allow["Local"] {
    # define list of allowed ip adresses from which the access is allowed
    allowedIps := ["127.0.0.1", "0:0:0:0:0:0:0:1"]

    # check that the request is to a local endpoint
    #input.requestedResource.url = ["v1", "local", _, _]
    input.requestedResource.url[0] = "v1"
    input.requestedResource.url[1] = "local"

    # check that the request comes from an allowed ip address
    input.details.remoteAddress == allowedIps[_]
}

# Allow access to endpoint for anonymous user
allow["AnonymousUser"] {
    # check that the user is authenticated as anonymous
    input.principal.user.username == "anonymousUser"
    
    # define urls that can be accessed by anonymous user
    allowedEndpoints := {
        ["v1", "connector", "register"],
        ["v1", "health", "liveness"],
        ["v1", "health", "readiness"]
    }

    # check if the requested url belongs to the set of allowed ones
    allowedEndpoints[input.requestedResource.url]	
}

default authorized = false