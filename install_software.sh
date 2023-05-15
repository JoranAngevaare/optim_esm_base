synda_dir_name="${1:-"$(pwd)/synda"}"

function announce {
    echo
    echo "#######################################################################################"
    echo "## $1       ("`date -u`")"
    echo
}
conda install -c "conda-forge/label/cf202003" cdo

announce "Start install on $(which python), and set synda dir to $synda_dir_name"
mkdir $synda_dir_name

announce "start building synda"
conda install -c IPSL synda  --yes -q

from_conda_forge="myproxy cartopy xesmf"
announce "install from confa forge: $from_conda_forge"
conda install -c conda-forge $from_conda_forge --yes -q

announce "install requirements"
pip install -r requirements.txt

announce "set ST_HOME"
# conda env config vars set ST_HOME=$synda_dir_name
