
# Project template

This repository contains a project template.
I intend this repo as the common starting point for research projects.
It can also be used to onboard new co-authors and research assistants.
Download the repository and compile `logbook/logbook.tex` to get started.

The following is the first page of `logbook.pdf` converted to Markdown.

## Research infrastructure
This chapter is intended to introduce everyone to technology or tools
that are integral to our workflow. It describes our research
infrastructure in terms of three types of issues:

-   **Code**: organize it, write it, run it, track it

-   **Collaboration**: assigning tasks, sharing code, reviewing code,
    reporting results

-   **Computing**: geeky details

We organize the project as a series of tasks, so our organization of
code and data takes a task-based perspective. After writing code, we
automate its execution via `make`. We track our code (and the rest of
the project) using `Git`, a version control system. Collaboration occurs
via issue/task assignments, pull requests, and logbook entries that
share research designs and results.

Use a good text editor like [SublimeText](https://www.sublimetext.com/),
[Atom](https://atom.io/), or [VSCode](https://code.visualstudio.com/) to
write code, slides, and papers. [Word processors aren't text
editors](http://plain-text.co/write-and-edit.html). Your text editor
should, at minimum, offer you [syntax
highlighting](https://en.wikipedia.org/wiki/Syntax_highlighting), [tab
autocomplete](https://en.wikipedia.org/wiki/Command-line_completion),
and [multiple selection](https://www.sublimetext.com/). We recommend
VSCode, which supports Git, remote development via SSH, and a GitHub
extension.

Our approach assumes that you'll use Unix/Linux/MacOSX. Plain-text
social science lives at the \*nix command line. [Gentzkow and
Shapiro](https://github.com/gslab-econ/ra-manual/wiki/Getting-Started):
"The command line is our means of implementing tools." Per [Janssens
(2014)](https://jeroenjanssens.com/dsatcl/chapter-1-introduction.html#why-data-science-at-the-command-line):
"the command line is: agile, augmenting, scalable, extensible, and
ubiquitous." Here are four intros to the Linux shell:

-   <https://ryanstutorials.net/linuxtutorial/>

-   <http://swcarpentry.github.io/shell-novice/>

-   Grant McDermott's "[Learning to love the
    shell](https://raw.githack.com/uo-ec607/lectures/master/03-shell/03-shell.html#1)"
    via his [Data science for
    economists](https://github.com/uo-ec607/lectures)

-   William E. Shotts, Jr's "[Learning the
    Shell](http://linuxcommand.org/lc3_learning_the_shell.php)"

Getting started at the command line can be a little overwhelming, but
it's well worth it. While you can use GUI apps to interact with most of
our workflow (e.g., GitHub Desktop), automation of some key parts relies
on shell scripts. See logbook entry A.9 for a haphazard collection of
shell tips.

Beyond \*nix, the rest of the research workflow is language-agnostic: it
applies to everything from Stata to Julia. In fact, the task-based
approach naturally facilitates using different languages for different
tasks.

I have five criteria in mind when evaluating a research workflow:

-   Replicability: Can the research results be reproduced starting from
    the raw data?

-   Portability: If I install a fresh copy of the project on a new
    computer, what are the startup costs before I can run the code?

-   Modularity: Can a coauthor work on a task using the provided inputs
    without having to look upstream at the code that produced those
    inputs?

-   Dependencies: In the event of a data update, how do you know which
    pieces of code need to be run (and in what order)?

-   History: If results have changed, can I discern the relevant code
    changes and their authors?

After reading the rest of this chapter, you should be able to say how
our workflow answers each of these questions.
