#include "mex.h"

/*
 * function [s, l] = L2SL(l0)
 *
 * History
 *   create  -  Feng Zhou, 03-20-2009
 *   modify  -  Feng Zhou, 12-21-2009
 */
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {

    // l0
    double *l0 = mxGetPr(prhs[0]);
    int n = mxGetN(prhs[0]);

    // s
    double *s = new double[n];

    // l
    double *l = new double[n];

    int m = 0;
    double c;
    double c0 = -1;
    for (int i = 0; i < n; ++i) {
        c = l0[i];
        if (c != c0) {
            s[m] = i + 1;
            l[m] = c;
            c0 = c;
            ++m;
        }
    }

    // output
    plhs[0] = mxCreateDoubleMatrix(1, m + 1, mxREAL);
    double *so = mxGetPr(plhs[0]);
    plhs[1] = mxCreateDoubleMatrix(1, m, mxREAL);
    double *lo = mxGetPr(plhs[1]);
    for (int i = 0; i < m; ++i) {
        so[i] = s[i];
        lo[i] = l[i];
    }
    so[m] = n + 1;
    
    delete[] s;
    delete[] l;
}
