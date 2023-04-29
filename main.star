NAME_ARG = "name"
IMAGE_ARG = "image"

HTTP_PORT_NAME = "http"

def run(plan, args):
    name = args.get(NAME_ARG, "nginx")
    image = args.get(IMAGE_ARG, "nginx:latest")

    plan.add_service(
        name = name,
        config = ServiceConfig(
            image = image,
            ports = {
                HTTP_PORT_NAME: PortSpec(number = 80, application_protocol = "http")
            }
        )
    )

    # Try out a plan.add_service here (https://docs.kurtosis.com/starlark-reference/plan#add_service)
