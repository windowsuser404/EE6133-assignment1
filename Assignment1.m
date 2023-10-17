file1 = 'music16khz.wav';
file2 = 'speech8khz.wav';
result1 = '16khzresult.wav';
result2 = '8khzresult.wav';
AAresult1 = '16khz_AA_result.wav';
AAresult2 = '8khz_AA_result.wav';
PartD_file1 = 'PartD_16khz.wav';
PartD_file2 = 'PartD_8khz.wav';
PartE_file1 = 'PartE_16khz.wav';
PartE_file2 = 'PartE_8khz.wav';
down_factor = 2;
Adown_factor = 4;
up_factor = 3;
[y1,F1s] = audioread(file1);
[y2,F2s] = audioread(file2);

%%%%%%%%%%%%%%%% Part A %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Yd1 = downsample(y1,down_factor);
Yd2 = downsample(y2,down_factor);
audiowrite(result1,Yd1,F1s/down_factor);
audiowrite(result2,Yd2,F2s/down_factor);
magSpec1 = fft(y1);
magSpecd1 = fft(Yd1);
magSpec2 = fft(y2);
magSpecd2 = fft(Yd2);
%%%%%%%%%%%%for plotting%%%%%%%%%%%%%%%%%
% f1 = figure('Name','16KHz');
% figure(f1);
% plot((0:length(magSpec1)-1)*2*pi/length(magSpec1),abs(magSpec1));
% f2 = figure('Name','8KHz');
% figure(f2);
% plot((0:length(magSpec2)-1)*2*pi/length(magSpec2),abs(magSpec2));
% f3 = figure('Name','16KHz_down');
% f4 = figure('Name','8KHz_down');
% figure(f3);
% plot((0:length(magSpecd1)-1)*2*pi/length(magSpecd1),abs(magSpecd1));
% figure(f4);
% plot((0:length(magSpecd2)-1)*2*pi/length(magSpecd2),abs(magSpecd2));
% %sound(y1,F1s);
%sound(Yd1,F1s/down_factor);

%%%%%%%%%%%%%%%% Part B %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Hd = low_pass();
Hd_8k = low_pass_8k();
AA_Y_16K = filter(Hd,y1);
AA_Y_16K_downsample = downsample(AA_Y_16K,down_factor);
magSpec_AA_y1 = fft(AA_Y_16K_downsample);  
AA_Y_8k = filter(Hd_8k,y2);
AA_Y_8k_downsample = downsample(AA_Y_8k,down_factor);
magSpec_AA_y2 = fft(AA_Y_8k_downsample);
%%%%%%%%%%%%%%%%%%%%%% Writing anti aliased back to
%%%%%%%%%%%%%%%%%%%%%% memory%%%%%%%%%%%%%%%%%%
audiowrite(AAresult1,AA_Y_16K_downsample,F1s/down_factor);
%%this below nomalising to not allow clipping to happen
non_clip_AA_Y_8k_downsample = AA_Y_8k_downsample/(max(AA_Y_8k_downsample));
audiowrite(AAresult2,non_clip_AA_Y_8k_downsample,F2s/down_factor);


%%%%%%%%%%%%%%%%%%%%% plotting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% freqz(Hd);
% freqz(Hd_8k);
% f5 = figure('Name','AAdown16k');
% f6 = figure('Name','AAdown8k');
% figure(f5);
% plot((0:length(magSpec_AA_y1)-1)*2*pi/length(magSpec_AA_y1),abs(magSpec_AA_y1));
% figure(f6);
% plot((0:length(magSpec_AA_y2)-1)*2*pi/length(magSpec_AA_y2),abs(magSpec_AA_y2));


%%%%%%%%%%%%%%%% Part C %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PartC_AA_16K = Part_c_16k();
PartC_AA_8K = Part_c_8k();
PartC_y1 = filter(PartC_AA_16K,y1);
PartC_yd1 = downsample(PartC_y1,Adown_factor);
PartC_y2 = filter(PartC_AA_8K,y2);
PartC_yd2 = downsample(PartC_y2,Adown_factor);
%freqz(PartC_AA_16K);
%freqz(PartC_AA_8K);


%%%%%%%%%%%%%%%% Part D %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PartD_AA_16K = Part_d_16k();
PartD_AA_8K = Part_d_8k();
Yp1 = upsample(y1,up_factor);
Yp2 = upsample(y2,up_factor);
magSpec_yp1 = fft(Yp1);
magSpec_yp2 = fft(Yp2);

PartD_AA_y1 = filter(PartD_AA_16K,Yp1);
PartD_AA_y2 = filter(PartD_AA_8K,Yp2);

PartD_result1 = downsample(PartD_AA_y1,Adown_factor);
PartD_result2 = downsample(PartD_AA_y2,Adown_factor);

magSpec_D_result1 = fft(PartD_result1);
magSpec_D_result2 = fft(PartD_result2);

audiowrite(PartD_file1,PartD_result1,F1s*up_factor/Adown_factor);
audiowrite(PartD_file2,PartD_result2,F2s*up_factor/Adown_factor);

%%%%%%%%%%%%%%%%%%%% plotting %%%%%%%%%%%%%%%%%%%%%
% f7 = figure('Name','Up_1');
% f8 = figure('Name','Up_2');
% figure(f7);
% plot((0:length(Yp1)-1)/length(Yp1)*F1s*up_factor,abs(magSpec_yp1));
% figure(f8)
% plot((0:length(Yp2)-1)/length(Yp2)*F2s*up_factor,abs(magSpec_yp2));
% f9 = figure('Name','Dres1');
% f10 = figure('Name','Dres2');
% figure(f9);
% plot((0:length(PartD_result1)-1)/length(PartD_result1)*F1s*up_factor/Adown_factor,abs(magSpec_D_result1));
% figure(f10);
% plot((0:length(PartD_result2)-1)/length(PartD_result2)*F2s*up_factor/Adown_factor,abs(magSpec_D_result2));



%%%%%%%%%%%%%%%% Part E %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PartE_Y1 = upsample(downsample(filter(PartC_AA_16K,y1),Adown_factor),up_factor); 
PartE_Y2 = upsample(downsample(filter(PartC_AA_8K,y2),Adown_factor),up_factor);
magSpec_Y1 = fft(PartE_Y1);
magSpec_Y2 = fft(PartE_Y2);

int_filter = intfilt(up_factor,5,"Lagrange"); %a simple 5th order lagrange filter
PartE_TEMPINT_y1 = conv(PartE_Y1,int_filter);
PartE_TEMPINT_y2 = conv(PartE_Y2,int_filter);
%%%%%%%%%%%%%%%to compensate for filter being [0:17] instead of
%%%%%%%%%%%%%%%[-8,8]%%%%%%%%%%%%%%%%%%%%
PartE_INT_Y1 = PartE_TEMPINT_y1(9:length(PartE_TEMPINT_y1));
PartE_INT_Y2 = PartE_TEMPINT_y2(9:length(PartE_TEMPINT_y2));
magSpec_INT_Y1 = fft(PartE_INT_Y1);
magSpec_INT_Y2 = fft(PartE_INT_Y2);
%%%%%%%%%%%%%normalise%%%%%%%%%%%%%%%%%%%%%
PartE_INT_Y1 = PartE_INT_Y1/max(PartE_INT_Y1);
PartE_INT_Y2 = PartE_INT_Y2/max(PartE_INT_Y2);
audiowrite(PartE_file1,PartE_INT_Y1/max(PartE_INT_Y1),F1s*up_factor/Adown_factor);
audiowrite(PartE_file2,PartE_INT_Y2/max(PartE_INT_Y2),F2s*up_factor/Adown_factor);

%%%%%%%%%%%%%%%%%%%plotting%%%%%%%%%%%%%%%%%%%%%%%
% f11 = figure('Name','PartE1');
% f12 = figure('Name','PartE2');
% f13 = figure('Name','Part_INTE1');
% f14 = figure('Name','Part_INTE2');
% figure(f11)
% plot((0:length(PartE_Y1)-1)/length(PartE_Y1)*F1s*up_factor/Adown_factor,abs(magSpec_Y1));
% figure(f12)
% plot((0:length(PartE_Y2)-1)/length(PartE_Y2)*F1s*up_factor/Adown_factor,abs(magSpec_Y2));
% figure(f13);
% plot((0:length(PartE_INT_Y1)-1)/length(PartE_INT_Y1)*F1s*up_factor/Adown_factor,abs(magSpec_INT_Y1));
% figure(f14)
% plot((0:length(PartE_INT_Y2)-1)/length(PartE_INT_Y2)*F2s*up_factor/Adown_factor,abs(magSpec_INT_Y2));