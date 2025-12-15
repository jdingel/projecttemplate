Welcome. You've just joined our research team or just bought a new computer, so you need to set up software from scratch.
This task contains scripts to help you do that.

We assume that you have a Mac.
`make` comes pre-installed on your Mac, so you can run `make` in this task folder (specifically, in `onboarding/code`).
Type `git --version` in the Terminal to confirm you have `git`, which you need to clone this repo, on your machine.
If you do not have `git`, install it as part the MacOS developer tools by running `xcode-select --install`.

If you run `make commandlinetools` in `onboarding/code`, that script will install [Homebrew](https://brew.sh/), a package manager for Mac,
and use it to install common shell programs ([wget](https://www.gnu.org/software/wget/), [ImageMagick](https://imagemagick.org/), etc).

If you run `make basictex`, it should install light-weight MacTeX and associated packages (but I haven't tested this yet myself).
See [BasicTeX](https://www.tug.org/mactex/morepackages.html).
I prefer a 117MB install to a [6GB install](https://www.tug.org/mactex/mactex-download.html), but you will need to use `tlmgr`, the TeX Live package manager, to install needed packages. Type `make ../output/TeX_packages.txt`.

If you run `make julia`, it'll check to see whether you have `juliaup`.
If you do not, it installs `juliaup` from the web.

You should also install the following software on your Mac:
- [VSCode](https://code.visualstudio.com/download)
