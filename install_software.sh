synda_dir_name="${1:-"$(pwd)/synda"}"

function announce {
    echo
    echo "#######################################################################################"
    echo "## $1       ("`date -u`")"
    echo
}

announce "Start install on $(which python), and set synda dir to $synda_dir_name"
mkdir $synda_dir_name

announce "install from confa forge: $from_conda_forge"
conda install -c IPSL synda==3.35  --yes -q

conda config --add channels conda-forge
conda config --set channel_priority flexible

announce "install from confa forge: $(cat conda_requirements.txt)"
conda install --file conda_requirements.txt --yes -q

announce "install requirements"
pip install -r requirements.txt

announce "set ST_HOME"
# conda env config vars set ST_HOME=$synda_dir_name
