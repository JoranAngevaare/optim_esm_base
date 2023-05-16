synda_dir_name="${1:-"$(pwd)/synda"}"

function announce {
    echo
    echo "#######################################################################################"
    echo "## $1       ("`date -u`")"
    echo
}

announce "Start install on $(which python), and set synda dir to $synda_dir_name"
mkdir $synda_dir_name

conda config --add channels conda-forge
conda config --add channels IPSL
conda config --set channel_priority flexible
#from_conda_forge="myproxy==6.2.6 cartopy==0.20.2 xesmf==0.6.3 cdo==2.0.3"
#announce "install from confa forge: $from_conda_forge"
conda install -c conda-forge --file conda_requirements.txt --yes -q

announce "install requirements"
pip install -r requirements.txt

announce "set ST_HOME"
# conda env config vars set ST_HOME=$synda_dir_name
