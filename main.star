NAME_ARG = "name"
IMAGE_ARG = "image"
CONFIG_FILES_ARTIFACT_ARG = "config_files_artifact"

HTTP_PORT_NAME = "http"

def run(plan, args):
    name = args.get(NAME_ARG, "nginx")
    image = args.get(IMAGE_ARG, "nginx:latest")
    config_file_artifact = args.get(CONFIG_FILES_ARTIFACT_ARG, "")

    files = {}
    if config_file_artifact != "":
        files = {
            "/etc/nginx/conf.d": config_file_artifact,
        }

    nginx_service = plan.add_service(
        name = name,
        config = ServiceConfig(
            image = image,
            ports = {
                HTTP_PORT_NAME: PortSpec(number = 80, application_protocol = "http")
            },
            files = files,
        )
    )

    return nginx_service
