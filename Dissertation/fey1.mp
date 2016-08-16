% fey1.mp -- do not edit, generated automatically by Rosemeyer_phd.tex
input feynmp
require_RCS_revision "1.30";
beginchar(1, 130*1.0pt#, 60*1.0pt#, 0);
"feynmf: 1";
LaTeX_unitlength:=1.0pt;
subgraph (0, 0, w, h);
vinit;
pickup pencircle scaled thin;
pickup pencircle scaled thick;
vleft (__i1, __i2);
vright (__o1, __o2);
vlabel ("$\psi _\gamma (\vx )$", __i1);
vlabel ("$\psi _\beta ^\dagger (\vx )$", __i2);
vlabel ("$\psi _\delta (\vx ')$", __o1);
vlabel ("$\psi _\alpha ^\dagger (\vx ')$", __o2);
vlabel ("$\vx $", __v1);
vlabel ("$\vx '$", __v2);
vconnect ("fermion", __i1, __v1, __i2);
vconnect ("fermion", __o1, __v2, __o2);
vconnect ("photon,label=$V_{\alpha \beta ;\gamma \delta }(\vx ,,\vx ')$", __v1, __v2);
vfreeze;
vdraw;
endsubgraph;
endchar;
% the end.
end.
endinput;
