import os
import pathlib
import importlib


def test_simple():
    import synda
    import numpy


def test_all():
    this_file_loc = pathlib.Path(__file__).parent.resolve()
    requirements_file = os.path.join(os.path.split(this_file_loc)[0], 'requirements.txt')
    assert os.path.exists(requirements_file), f'No such file {requirements_file} (this test runs from {this_file_loc})'

    with open(requirements_file) as requirements:
        for req in requirements.read().split('\n'):
            if req.startswith('#'):
                continue
            module = req.split('==')[0]
            print(f'load {module}')
            print(importlib.import_module(module))
