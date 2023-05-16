env_name="${1:-"optimesm"}"
synda_dir_name="${2:-"($pwd)/synda"}"
py_version='3.8.16'


echo "Start install, conda create $env_name, python=$py_version and set synda dir to $synda_dir_name"
mkdir $synda_dir_name

echo "start building env"
conda create -n $env_name python=$py_version --yes

conda activate $env_name
