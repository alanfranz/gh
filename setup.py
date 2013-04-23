from setuptools import setup, find_packages

setup(
    name = "gh",
    version = "1.0dev", 

    install_requires = [ 
        "Baker==1.1", 
        ],

    entry_points = {
        "console_scripts":["gh=gh.gh:main"]
        },

    packages = find_packages(),
    author = "Alan Franzoni",
    author_email = "username@franzoni.eu",
    description = "Mercurial-like CLI for Git",
    license = "MIT",
    url = "https://github.com/alanfranz/gh", 
    )


