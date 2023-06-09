echo "Set notebook extensions"
# https://github.com/jupyter-server/jupyter-resource-usage
jupyter serverextension enable --py jupyter_resource_usage --sys-prefix
jupyter nbextension install --py jupyter_resource_usage --sys-prefix
jupyter nbextension enable --py jupyter_resource_usage --sys-prefix
jupyter contrib nbextension install --sys-prefix
jupyter nbextension enable scratchpad/main --sys-prefix
jupyter contrib nbextension install --user
jupyter nbextension enable execute_time/ExecuteTime
