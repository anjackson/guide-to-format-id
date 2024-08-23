DigiPres Sandbox
=================

This project makes it possible to play with the tools supported by the [DigiPres Toolbox](https://github.com/digipres/toolbox), running it in the cloud so you can access it via your browser!

It works because it takes advantage of [Binder](https://jupyter.org/binder), which was built to support reproducibility in scientific research.  By clicking the button below, you can fire up a remote Linux session with a [Jupyter](https://jupyter.org/) interface, and start experimenting...

<a href="https://mybinder.org/v2/gh/digipres/sandbox/master" rel="nofollow" target="_blank"><img src="https://mybinder.org/badge_logo.svg" style="max-width: 100%;"></a>

**NOTE** please be patient, as it might take a minute or two to before things get started. Note also that this is an an ephemeral service and your session will be shut down after a while, especially if it's not doing anything.

If you want some help to get started, you can find an introduction in the [DigiPres Workbench](https://github.com/digipres/workbench).

## Sample Files

Some test files are included (taken from the [Open Preservation Foundation Format Corpus](https://github.com/openpreserve/format-corpus)). You can also upload your own files using the Jupyter interface.

**NOTE** that while any files you upload to this cloud-hosted service _should_ remain private, this cannot be guaranteed. Do not upload sensitive material!

## Developing The Sandbox

To work on the files in this repository you need Docker and Python 3. You can then install the Binder tools:

```
pip install jupyter-repo2docker
```

And then use the `./build-and-run-here.sh` script which runs this command:

```
jupyter-repo2docker -v .:/home/${USER} .
```

This means the local folder is passed through and you can keep any changes you make to the files.


### Setting the workspace layout

The layout of the workspace, e.g. tabs and notebook arrangements, can be saved and restored as per the example given here: https://github.com/ian-r-rose/binder-workspace-demo/
