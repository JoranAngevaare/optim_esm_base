# optim_esm_base
Base for OptimESM software


# Full Installation (on linux)

```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh .
bash Miniconda3-latest-Linux-x86_64.sh

git clone https://github.com/JoranAngevaare/optim_esm_base
cd optim_esm_base
conda install python=3.8.19
bash create py38 SOME_SYNDA_PATH
conda activate py38
bash install_software.sh --installer conda --synda_dir SOME_SYNDA_PATH
pytest test

bash set_jupy.sh
```
This package is the base 
```
## Optional optim_esm_tools
git clone https://github.com/JoranAngevaare/optim_esm_tools.git ../oet
bash ../oet/.github/scripts/write_synda_cridentials.sh
bash ../oet/.github/scripts/download_example_data.sh
bash ../oet/.github/scripts/install_tex.sh
pip install -e ../oet
python -c "import optim_esm_tools as oet; oet.utils.print_versions(); print('import cartopy'); import cartopy; print('setup map'); oet.plotting.plot.setup_map(); print('done'); oet.utils.print_versions('shapely cartopy urllib'.split())"
pytest -vx ../oet --durations 0
```
