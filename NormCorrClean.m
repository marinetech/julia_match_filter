function Corr = NormCorrClean(Data,Ref)
% function[Corr] = NormCorrVer0(Data,Ref)
%
%  Description: This function perform normalized correlation between ...
%               a refference signal and data signal. It can calculate the ...
%               correlation output in time domain or frequency domain.
%               It also can return normalized correlation.
%
% Input parameters:
%             Data - The data signal.
%             Ref - The refference signal.
%
%  Output parameters:
%            Corr - The correlation result.
%

StartIndx = length(Ref) ;
StopIndx = length(Data) + length(Ref) -1 ;

% Assure row vectors
Data = Data(:).';
Ref = Ref(:).';

K = sqrt( Ref * Ref');      % power of the reference;
RefL = length(Ref);         % The length of the reference
DataLen = length(Data);     % The length of the data

% method 1 - fft implementation
pad = 2 ^ nextpow2(RefL + DataLen  - 1);% Padding to a power of 2 for the fft function
Corr= ifft(fft(Data,pad).*fft(conj(fliplr(Ref)),pad)); % Correlation in frequency domain
% figure;plot(abs(Corr))
Corr = Corr( StartIndx : StopIndx );  % cutting the fft implementation to the supposed length.
% Normalize the correlation
Data = [zeros(1,RefL-1) Data zeros(1,RefL)]; % zero padding to perform normalization
SumX2 = sum(abs(Data(StartIndx: StartIndx + RefL - 1)).^2); % the energy of each point
for ind = StartIndx:StopIndx
    Corr(ind -  StartIndx + 1) = Corr(ind -  StartIndx + 1) / sqrt( SumX2) ;
    SumX2 = SumX2 + abs(Data(ind + RefL )).^2 - abs(Data(ind)).^2;
end
% Normalize the correlation
Corr = Corr/K;

