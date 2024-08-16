from setuptools import setup
from Cython.Build import cythonize

setup(
    ext_modules = cythonize("src/browser.pyx", language_level="3"),
    zip_safe=False,
)
