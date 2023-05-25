synda_dir_name="${2:-"$(pwd)/synda"}"
full_install="${1:-"full"}"

function announce {
    echo
    echo "#######################################################################################"
    echo "## $1       ("`date -u`")"
    echo
}

if [[ full_install == "full" ]]; then
    announce "Start install on $(which python), and set synda dir to $synda_dir_name"
    mkdir $synda_dir_name

    synda_v="synda==3.35"
    announce "install $synda_v from IPSL"
    conda install -c IPSL $synda_v  --yes -q
fi

announce "install from confa forge: $(cat conda_requirements.txt)"
conda install -c conda-forge --file conda_requirements.txt --yes -q

announce "install requirements"
pip install -r requirements.txt

announce "set ST_HOME"
# conda env config vars set ST_HOME=$synda_dir_name
