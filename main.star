NAME_ARG = "name"
IMAGE_ARG = "image"
PORT_ID = "port_id"
PORT_NUMBER = "port_number"
FILE_ARTIFACTS = "files_artifacts"
DEFAULT_SERVICE_NAME = "nginx"
DEFAULT_IMAGE = "nginx:latest"
DEFAULT_CONFIG_FILEPATH = "/etc/nginx/conf.d"
DEFAULT_PORT_ID = "http"
DEFAULT_PORT_NUMBER = 80
HTTP_PORT_APP_PROTOCOL = "http"
ENV_VARS_ARG = "env_vars"

def run(plan, args = {}):
    name = args.get(NAME_ARG, DEFAULT_SERVICE_NAME)
    image = args.get(IMAGE_ARG, DEFAULT_IMAGE)
    port_id = args.get(PORT_ID, DEFAULT_PORT_ID)
    port_number = args.get(PORT_NUMBER, DEFAULT_PORT_NUMBER)
    file_artifacts = args.get(FILE_ARTIFACTS, "")
    env_vars_received = args.get(ENV_VARS_ARG, "")

    files = {}
    if file_artifacts != "":
        files = file_artifacts

    env_vars = {}
    if env_vars_received != "":
        env_vars = env_vars_received

    nginx_service = plan.add_service(
        name = name,
        config = ServiceConfig(
            image = image,
            ports = {
                port_id: PortSpec(number = port_number, application_protocol = HTTP_PORT_APP_PROTOCOL)
            },
            files = files,
            env_vars = env_vars,
        )
    )

    return nginx_service
