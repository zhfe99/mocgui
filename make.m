% Make file.
path0 = cd;

cd 'lib/text';
mex atoi.cpp;
mex atof.cpp;
mex tokenise.cpp;
cd(path0);
