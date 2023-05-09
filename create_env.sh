env_name="${1:-"optimesm"}"
synda_dir_name="${2:-"($pwd)/synda"}"
mkdir $synda_dir_name
py_version='3.8.16'

echo "Start install, conda create $env_name, python=$py_version and set synda dir to $synda_dir_name"
yes |  conda create -n $env_name python=$py_version
# sudo apt-get install myproxy
conda activate $env_name
yes | conda install -c IPSL synda
yes | conda install -c conda-forge cdo
yes | conda install -c conda-forge cartopy
yes | conda install -c conda-forge myproxy
pip install -r requirements.txt
conda env config vars set ST_HOME=$synda_dir_name

# https://github.com/jupyter-server/jupyter-resource-usage
jupyter serverextension enable --py jupyter_resource_usage --sys-prefix
jupyter nbextension install --py jupyter_resource_usage --sys-prefix
jupyter nbextension enable --py jupyter_resource_usage --sys-prefix
jupyter contrib nbextension install --sys-prefix
jupyter nbextension enable scratchpad/main --sys-prefix
jupyter contrib nbextension install --user
jupyter nbextension enable execute_time/ExecuteTime
