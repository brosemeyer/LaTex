% fey_ladders1.mp -- do not edit, generated automatically by Rosemeyer_phd.tex
input feynmp
require_RCS_revision "1.30";
beginchar(1, 40*1.0pt#, 20*1.0pt#, 0);
"feynmf: 1";
LaTeX_unitlength:=1.0pt;
subgraph (0, 0, w, h);
vinit;
pickup pencircle scaled thin;
vbottom (__i1, __d1, __o1);
vtop (__i2, __d2, __o2);
vconnect ("fermion", __i1, __v1, __v2, __o1);
vconnect ("fermion", __o2, __v4, __v3, __o2);
vconnect ("photon,tension=0", __v1, __v3);
vconnect ("photon,tension=0", __v2, __v4);
vfreeze;
vdraw;
endsubgraph;
endchar;
% the end.
end.
endinput;
