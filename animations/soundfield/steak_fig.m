% Used SFS Toolbox version: 4bf1155
%
% Creates a figure showing the sound field in time domain of two competing
% talkers

% --- Configuration ---
% Listening area
X = [-2 2];
Y = [-2 2];
Z = 0;
% Source positions
x0 = [-1 1 0; 1 1 0];
% Source files
file1 = 'speaker1.wav';
file2 = 'speaker2.wav';

% --- Main ---
conf = SFS_config;
[~,~,~] = mkdir('./','data');

[s1,fs1] = audioread(file1);
[s2,fs2] = audioread(file2);

if fs1<fs2
    s2 = resample(s2,fs2,fs1);
    conf.fs = fs1;
elseif fs2<fs1
    s1 = resample(s1,fs1,fs2);
    conf.fs = fs2;
end

conf.plot.usedb = 1;
conf.plot.normalization = 'max';
conf.plot.usenormalisation = false;
x0 = [x0 [0 -1 0 1; 0 -1 0 1]];
d = [s1(1:5000) s2(1:5000)];
for t=3000:10:5000
    filename = sprintf('data/sfs%04.0f.dat',t);
    [p,x,y] = sound_field_imp(X,Y,Z,x0,'ps',d,t,conf);
    gp_save_matrix(filename,x,y,p);
end
