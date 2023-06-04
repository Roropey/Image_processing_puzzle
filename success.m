function success(reconstructedImage)

    msgbox("Operation Completed","Success","custom",reconstructedImage);
    
    notecreate = @(frq,dur) sin(2*pi* [1:dur]/8192 * (440*2.^((frq-1)/12)));
    notename = {'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#'};
    song = {'A#' 'E' 'F'};
    for k1 = 1:length(song)
        idx = strcmp(song(k1), notename);
        songidx(k1) = find(idx);
    end    
    dur = 0.3*3000;
    songnote = [];
    for k1 = 1:length(songidx)
        songnote = [songnote; [notecreate(songidx(k1),dur)  zeros(1,75)]'];
    end
    soundsc(songnote, 8192)    

%     load handel
%     sound(y,Fs)
    
end