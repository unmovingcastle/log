(Install_pueoBuilder)=
# Install pueoBuilder

This is the original {download}`guide <pueo_installation_guide.pdf>` from Kaeli.

(installing_on_osc)=
## Installing on OSC

### installing Mamba (Conda)

We use mamba instead of Conda because it is much faster.
It is possible to install [Mamba](https://mamba.readthedocs.io/en/latest/>) through
an existing Anaconda (or Miniconda) installation, but this method is not recommended by Mamba.

Instead, head over to the 
[Mambaforge (aka Miniforge) distribution](https://github.com/conda-forge/miniforge#mambaforge)
and download Mamba installation script through
```bash
wget "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh"
```
and run
```bash
bash Miniforge3-Linux-x86_64.sh
```
to install the Linux x86_64 (amd64) version of Mambaforge (read the license agreement,
type `yes` and press {kbd}`Enter`)

Next, initialize Mamba through
```bash
mamba init bash
```
or if you use zshell,
```bash
mamba init zsh
```
This will set up your `.bashrc` (`.zshrc`) file for mamba.

Mamba might might ask you
> Do you wish the installer to initialize Miniforge3 by running conda init? [yes|no]

and you should enter `yes`.
You will need to exit the terminal and re-open for the change to take effect.
Once done, you should see `(base)` showing up on your terminal prompt, indicating the base
environment is active.

If not, try entering 
`bash`.

You can confirm that you have an environment called "base" by entering the command
```bash
conda info --env
```

You may delete the installation script through
`rm Miniforge3-Linux-x86_64.sh`.

Next, you would want to install `conda-devenv` through 
`mamba install conda-devenv`. You can find the documentation for `conda-devenv` 
[here](https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh)


### create PUEO environment

Next, we will create an environment using `mamba`.
Using `vim` or any editor, create a text file called `pueo.devenv.yml` containing the following:
```yaml
name: pueo_env
channels:
  - conda-forge
  - defaults

dependencies:
  - fftw
  - root

variables:
  PUEO_BUILD_DIR: /users/PASxxxx/${USERNAME}/pueo/usr
  PUEO_UTIL_INSTALL_DIR: /users/PASxxxx/${USERNAME}/pueo/usr/install
  NICEMC_SRC: /users/PASxxxx/${USERNAME}/pueo/usr/components/nicemc
  NICEMC_BUILD: /users/PASxxxx/${USERNAME}/pueo/usr/build/components/nicemc
  PUEOSIM_SRC: /users/PASxxxx/${USERNAME}/pueo/usr/components/pueoSim
```
```{important}
Change PASxxxx/${USERNAME} to where your home directory is located!
```

In the terminal, type `cd ~` to go back to your home directory, and create a `pueo` directory
through `mkdir -p ~/pueo`.

Put the `pueo.devenv.yml` file inside your pueo folder and enter the folder: `cd ~/pueo`.

Make sure that `(base)` is active. If not, run `conda activate base`.
Next, create a new environment called `pueo_env` through 
```bash
mamba-devenv -f pueo.devenv.yml
```

```{important}
It is important that you run `mamba-devenv` and not `conda-devenv` or `mamba devenv`.
Anything that is not `mamba-devenv` seems to be exceedingly slow on OSC
```

The above command creates a conda environment with required packages and environment variables
(such as `${PUEO_BUILD_DIR}`). Activate this new environment through
```bash
conda  activate peuo_env
```
(or `mamba activate pueo_env`)

### installing cmake

OSC has [cmake](https://www.osc.edu/resources/available_software/software_list/cmake) 
already installed. To use cmake version 3.11.4, run
```bash
module load cmake/3.11.4
```
and check that the version is activated through `cmake --version`.

### clone the pueoBuilder repository

+  Refer to {doc}`setting_up_github_ssh` to set up your GitHub credentials.

+  Make sure that the `pueo_env` environment is actived.

+  `cd ~/pueo` and then clone the 
    [pueoBuilder repository](https://github.com/PUEOCollaboration/pueoBuilder)
    through
    ```bash
    git clone git@github.com:PUEOCollaboration/pueoBuilder ./usr
    ```
    This would put every file in the pueoBuilder repository inside a newly created 
    folder called `~/pueo/usr/`.

+   Create a folder inside `~/pueo/usr/` called `install` through
    ```bash
    mkdir ~/pueo/usr/install
    ```

+  `cd` into `usr` and enter the following command:
    ```bash
    ./pueoBuilder.sh
    ```

### pueoSim test run
Create a temporary folder in your home directory through
```bash
mkdir ~/temp
```
and head over to to the pueoBuilder directory `cd ~/pueo/usr`. Start a test run through
```bash
./build/components/pueoSim/simulatePueo -i pueo.conf -o ~/temp -r 420 -n 50
```
where `i`/`o` stand for `i`nput/`o`utput files, `r` is the run number (just a name) and
`n` is the number of `n`eutrinots.

Once the run is complete, you should see a bunch of root files in the temporary folder.

Congratulations, you have completed pueoSim installation!


## Installing on Fedora Linux

See {ref}`installing_on_osc`. 
The steps are pretty much the same.

Fedora most like already has CMake installed. If not, run
```bash
sudo dnf install cmake
```
to install cmake. You need your password for this.

Alternatively, refer to CMake section in the original document 
{ref}`Install_pueoBuilder` to compile CMake.

## Installing on macOS

I haven't figure out how to do this.
Maybe it is easier to install Asahi Linux on Mac and then run through all the steps in
{ref}`installing_on_osc`.


