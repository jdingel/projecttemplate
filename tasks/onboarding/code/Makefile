R_VERSION = 4.4.0 # R version

all:
	echo This task has an empty default target. Please specify if you want to 'make commandlinetools' or something else.
	echo Use 'make commandlinetools' to install Homebrew and tools like graphviz, wget, etc.
	echo Use 'make basictex' to install BasicTeX and 'make ../output/TeX_packages.txt' to install TeX packages.
	echo Use 'make julia' to install Julia via juliaup.
	echo Use 'make R' to install R.

.PHONY: commandlinetools basictex julia R

commandlinetools: homebrew_installed.sh
	bash homebrew_installed.sh
	for pkg in graphviz wget ghostscript imagemagick; do \
		brew search "$$pkg" ;\
		brew install --ask "$$pkg" ;\
	done

basictex:  homebrew_installed.sh
	bash homebrew_installed.sh
	brew install --ask --cask basictex

../output/TeX_packages.txt: TeX_packages.sh | ../output
	command -v tlmgr >/dev/null 2>&1 || { echo "Error: 'tlmgr' is not installed or not in PATH."; exit 1; }
	echo "The tlmgr command requires sudo privileges to run. It will ask for your password."
	bash $<

julia:
	@if command -v juliaup >/dev/null 2>&1; then \
		echo "juliaup is already installed! Use 'juliaup' to manage Julia versions. Type 'juliaup --help' for more info."; \
	else \
		echo "juliaup not found. Installing Julia via juliaup..."; \
		curl -fsSL https://install.julialang.org | sh; \
		echo "Installation complete! Restart your shell or run:"; \
		echo "  source ~/.bashrc  # or ~/.zshrc depending on your shell"; \
	fi
R: ../output/R_installed.txt
	@echo "R is already installed! Use 'R' to start the R console."
../output/R_installed.txt: install_R.sh | $(OOPR)
	@bash $< $(R_VERSION)

../output:
	mkdir ../output
