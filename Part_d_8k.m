function Hd = Part_c_8k
%PART_C_8K Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.12 and Signal Processing Toolbox 9.0.
% Generated on: 29-Sep-2023 14:26:59

% Equiripple Lowpass filter designed using the FIRPM function.

% All frequency values are in Hz.
Fs = 24000;  % Sampling Frequency

Fpass = 3*880;           % Passband Frequency
Fstop = 3*1120;          % Stopband Frequency
Dpass = 1e-10;  % Passband Ripple
Dstop = 1e-10;        % Stopband Attenuation
dens  = 20;            % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fpass, Fstop]/(Fs/2), [1 0], [Dpass, Dstop]);

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, Fo, Ao, W, {dens});
Hd = dfilt.dffir(b);

% [EOF]