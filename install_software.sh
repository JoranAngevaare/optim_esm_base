#!/bin/bash
POSITIONAL_ARGS=()

# Thanks https://stackoverflow.com/a/14203146/18280620
while [[ $# -gt 0 ]]; do
    case "$1" in
        --installer)
            installer="$2"
            shift 2
            ;;
        --no_synda)
            no_synda=1
            shift
        ;;
        --no_cdo)
            no_cdo=1
            shift
        ;;
        --only_synda)
            only_synda=1
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


installer="${installer:-"mamba"}"
synda_dir_name="${synda_dir:-"$(pwd)/synda"}"

if [[ $installer == "miniforge" ]];
then
    announce "using miniforge (subcommands are calling \"conda\")"
    installer="conda"
fi

echo "args are" synda_dir:$synda_dir_name no_synda:$no_synda no_cdo:$no_cdo installer:$installer

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
    $installer env config vars set BASE_SYNDA_CDO=1
else
    announce "Start install on $(which python), and set synda dir to $synda_dir_name"
    if [[ -d "$synda_dir_name" ]]
    then
        echo "$synda_dir_name exists on your filesystem."
    else
        mkdir $synda_dir_name
    fi

    announce "install synda from IPSL"
    $installer install -c IPSL --file synda_version.txt --yes -q

    announce "set ST_HOME"
    $installer env config vars set ST_HOME=$synda_dir_name
fi

if [[ $only_synda == 1 ]];
then
    announce "stopping here, synda is installed"
    exit 0
fi

if [[ $no_cdo == 1 ]];
then
    echo "Skip CDO install"
    cat conda_requirements.txt | grep -v "#" | grep -v cdo >> tmp.txt
    $installer env config vars set BASE_NO_CDO=1
else
    cat conda_requirements.txt | grep -v "#" | grep -v "somethingsomething" >> tmp.txt
fi

if [[ "$installer" == 'conda' ]];
then
    announce "install from conda forge:\n$(cat tmp.txt)"
    conda install  -c conda-forge --file tmp.txt --yes -q
else
    # Todo, this is akward, I think mamba does not parse --file well
    # See https://github.com/JoranAngevaare/optim_esm_base/pull/54
    announce "install from conda forge:\n$(cat tmp.txt)"
    for dep in $(cat tmp.txt);
    do
        announce "install $dep";
        $installer install -c conda-forge "$dep" --yes;
    done
fi
rm tmp.txt

announce "install requirements"
pip install -r requirements.txt

announce "installation complete"
