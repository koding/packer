#!/bin/bash

set -o errexit

# Miscellaneous

$YUM install graphviz

pip install psutil superlance
