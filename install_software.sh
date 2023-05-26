#!/bin/bash
POSITIONAL_ARGS=()

# Thanks https://stackoverflow.com/a/14203146/18280620
while [[ $# -gt 0 ]]; do
    case "$1" in
        --no_synda)
            no_synda=1
            shift
        ;;
        --no_cdo)
            no_cdo=1
            shift
        ;;
        --synda_dir)
            synda_dir="$2"
            shift 2
        ;;
        -*|--*)
            echo "Unknown option $1"
            exit 1
        ;;
        *)
            break
        ;;
    esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters


synda_dir_name="${synda_dir:-"$(pwd)/synda"}"

echo "args are" synda_dir:$synda_dir_name no_synda:$no_synda no_cdo:$no_cdo

function announce {
    echo
    echo "#######################################################################################"
    echo "## ("`date -u`")"
    printf "## $1\n"
    echo
}

if [[ $no_synda == 1 ]];
then
    echo "Skip SYNDA install"
    mamba env config vars set BASE_SYNDA_CDO=1
else
    announce "Start install on $(which python), and set synda dir to $synda_dir_name"
    if [[ -d "$synda_dir_name" ]]
    then
        echo "$synda_dir_name exists on your filesystem."
    else
        mkdir $synda_dir_name
    fi
    
    synda_v="synda==3.35"
    announce "install $synda_v from IPSL"
    mamba install -c IPSL $synda_v  --yes -q
    
    announce "set ST_HOME"
    mamba env config vars set ST_HOME=$synda_dir_name
fi

if [[ $no_cdo == 1 ]];
then
    echo "Skip CDO install"
    cat conda_requirements.txt | grep -v cdo >> tmp.txt
    mamba env config vars set BASE_NO_CDO=1
else
    cat conda_requirements.txt | grep -v "somethingsomething" >> tmp.txt
fi

announce "install from conda forge:\n$(cat tmp.txt)"
for dep in $(cat tmp.txt);
do
    announce "install" $dep;
    mamba install -c conda-forge $dep --yes -q;
done
rm tmp.txt

announce "install requirements"
pip install -r requirements.txt
