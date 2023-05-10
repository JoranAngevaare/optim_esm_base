synda_dir_name="${1:-"$(pwd)/synda"}"

function announce {
    echo
    echo "#######################################################################################"
    echo "## $1       ("`date -u`")"
    echo
}

announce "Start install on $(which python), and set synda dir to $synda_dir_name"
mkdir $synda_dir_name

announce "start building synda"
conda install -c IPSL synda  --yes
announce "start building xesmf"
conda install -c conda-forge xesmf
announce "start building myproxy"
conda install -c conda-forge myproxy --yes
announce "install requirements"
pip install -r pinned_versions.txt
announce "set ST_HOME"
conda env config vars set ST_HOME=$synda_dir_name
