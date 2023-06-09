import os
import pathlib
import importlib


def test_simple():
    if os.environ.get("BASE_NO_SYNDA", 0):
        import synda
    import numpy


def test_all(
    excluded=(
        "gitpython",
        "ipython",
        "ipython-genutils",
        "jupyter-contrib-nbextensions",
        "jupyter-events",
        "jupyter-highlight-selected-word",
        "jupyter-contrib-core",
        "jupyterlab-widgets",
        "jupyter-nbextensions-configurator",
        "jupyterlab-pygments",
        "jupyter-resource-usage",
        "jupyter-console",
        "jupyter_server_terminals",
        "pyshp",
        "nc-time-axis",
        "texlive-core",
    )
):
    this_file_loc = pathlib.Path(__file__).parent.resolve()
    requirements_file = os.path.join(
        os.path.split(this_file_loc)[0], "requirements.txt"
    )
    assert os.path.exists(
        requirements_file
    ), f"No such file {requirements_file} (this test runs from {this_file_loc})"
    missing = []
    with open(requirements_file) as requirements:
        for req in requirements.read().split("\n"):
            if req.startswith("#"):
                continue
            # Strip any comments or == > etc signs
            module = (
                req.split("=")[0]
                .split("<")[0]
                .split(">")[0]
                .split("#")[0]
                .split(" ")[0]
            )
            if module == "cdo" and os.environ.get("BASE_NO_CDO", 0):
                print(f"Skip CDO, as it't not installed")
            if not module:
                continue
            print(f"load {module}")
            try:
                print(importlib.import_module(module))
            except Exception as e:
                print(f"{module} ran into {e}")
                missing.append(module)
    missing = set(missing) - set(excluded)
    if missing:
        raise ValueError(f"Missing {len(missing)} modules:" + "\n".join(missing))
