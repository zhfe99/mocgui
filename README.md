Introduction
============

This page contains software and instructions for a GUI interface for
viewing motion capture data.

<!-- The implementations of the above methods are taken from the authors' -->
<!-- websites (The code of GA was also implemented in the code of SMAC). We -->
<!-- appreciate all the authors for their generosity in sharing codes. -->


Installation
============

1. Download the code via `git clone https://github.com/zhfe99/mocgui` or from this [link](https://github.com/zhfe99/mocgui/archive/master.zip);
2. Set `mocgui/` as the current folder in Matlab;
2. Run `addPath` in Matlab to add sub-directories into the path of Matlab.
3. Run `mocGui` in Matlab.


Instructions
============

The package of `mocgui.zip` contains the following files and folders:

- `./data`: This folder contains a subset of the [CMU Motion Capture dataset](http://mocap.cs.cmu.edu).

- `./src`: This folder contains the main implementation of FGM as well
       as other baselines.

- `./lib`: This folder contains some necessary library functions.

- `./addPath.m`: Adds the sub-directories into the path of Matlab.

- `./mocGui.m`: The main implementation of the GUI interface.

- `./mocGui.fig`: The Matlab fig file to save the window configuration.

Copyright
==========

This software is free for use in research projects. If you publish
results obtained using this software, please use this citation.

    @article{ZhouDH13,
        author    = {Feng Zhou and Fernando {De la Torre} and Jessica K. Hodgins},
        title     = {Hierarchical Aligned Cluster Analysis for Temporal Clustering of Human Motion},
        journal   = {IEEE Transactions Pattern Analysis and Machine Intelligence (PAMI)},
        year      = {2013},
        volume    = {35},
        number    = {3},
        pages     = {582-596},
    }

If you have any question, please feel free to contact Feng Zhou (zhfe99@gmail.com).
