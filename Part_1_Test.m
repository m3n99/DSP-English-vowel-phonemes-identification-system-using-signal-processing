%% Get Directory
training_files_had = dir('C:\Users\hp\Desktop\DSP Project\Train\had\*.wav');
testing_files_had = dir('C:\Users\hp\Desktop\DSP Project\Test\had\*.wav');
training_files_hade = dir('C:\Users\hp\Desktop\DSP Project\Train\hade\*.wav');
testing_files_hade =dir('C:\Users\hp\Desktop\DSP Project\Test\hade\*.wav');
training_files_hard = dir('C:\Users\hp\Desktop\DSP Project\Train\hard\*.wav');
testing_files_hard =dir('C:\Users\hp\Desktop\DSP Project\Test\hard\*.wav');
training_files_head = dir('C:\Users\hp\Desktop\DSP Project\Train\head\*.wav');
testing_files_head = dir('C:\Users\hp\Desktop\DSP Project\Test\head\*.wav');
training_files_heard = dir('C:\Users\hp\Desktop\DSP Project\Train\heard\*.wav');
testing_files_heard = dir('C:\Users\hp\Desktop\DSP Project\Test\heard\*.wav');
training_files_heed = dir('C:\Users\hp\Desktop\DSP Project\Train\heed\*.wav');
testing_files_heed = dir('C:\Users\hp\Desktop\DSP Project\Test\heed\*.wav');
training_files_hid = dir('C:\Users\hp\Desktop\DSP Project\Train\hid\*.wav');
testing_files_hid = dir('C:\Users\hp\Desktop\DSP Project\Test\hid\*.wav');
training_files_hide = dir('C:\Users\hp\Desktop\DSP Project\Train\hide\*.wav');
testing_files_hide = dir('C:\Users\hp\Desktop\DSP Project\Test\hide\*.wav');
training_files_hoard = dir('C:\Users\hp\Desktop\DSP Project\Train\hoard\*.wav');
testing_files_hoard = dir('C:\Users\hp\Desktop\DSP Project\Test\hoard\*.wav');
training_files_hod = dir('C:\Users\hp\Desktop\DSP Project\Train\hod\*.wav');
testing_files_hod = dir('C:\Users\hp\Desktop\DSP Project\Test\hod\*.wav');
training_files_hood = dir('C:\Users\hp\Desktop\DSP Project\Train\hood\*.wav');
testing_files_hood = dir('C:\Users\hp\Desktop\DSP Project\Test\hood\*.wav');
training_files_hudd = dir('C:\Users\hp\Desktop\DSP Project\Train\hudd\*.wav');
testing_files_hudd = dir('C:\Users\hp\Desktop\DSP Project\Test\hudd\*.wav');
training_files_whod = dir('C:\Users\hp\Desktop\DSP Project\Train\whod\*.wav');
testing_files_whod = dir('C:\Users\hp\Desktop\DSP Project\Test\whod\*.wav');
test_file=dir("C:\Users\hp\Desktop\DSP Project\DSP_Project_testing\*.wav");
%% ---------------------------Training---------------------------
rhad=(tr(training_files_had));
rhade=(tr(training_files_hade));
rhard=(tr(training_files_hard));
rhead =(tr(training_files_head));
rheard=(tr(training_files_heard));
rheed=(tr(training_files_heed));
rhid=(tr(training_files_hid));
rhide=(tr(training_files_hide));
rhoard=(tr(training_files_hoard));
rhod=(tr(training_files_hod));
rhood=(tr(training_files_hood));
rhudd=(tr(training_files_hudd));
rwhod=(tr(training_files_whod));
%% ---------------------------Testing---------------------------

training_array = [rhad' rhade' rhard' rhead' rheard' rheed' rhid' rhide' rhoard' rhod' rhood' rhudd' rwhod'];
text = ["had" "hade" "hard" "head" "heard" "heed" "hid" "hide" "hoard" "hod" "hood" "hudd" "whod"];
tsts(test_file,text,training_array);

function [arr]= tr(file)
arr=zeros(4000,1)';
for i = 1:length(file)
    file_path = strcat(file(i).folder,'\',file(i).name);% get the file path with name
    [y, fs] = audioread(file_path); % read the audio file
    y=y-mean(y);
    y=y(200:6000);
    arr=sigadd(arr,y);
end
arr=arr./7;
end
function tsts(file,text,arr)
for i = 1:length(file)
    file_path = strcat(file(i).folder,'\',file(i).name);
    [y,fs] = audioread(file_path);
    y=y-mean(y);
    sound(y,fs);
    m=[];
    for j=1:13
        m=[m max(abs(xcorr(y,arr(:,j)')))];
    end
    [~, index]=max(m);
        fprintf('Test file[%d]#classified  %s \n',i,text(index));
pause(2);
end
end

function [arr]= sigadd(arr,arr2)
for i =1:min(length(arr),length(arr2))
    arr(i)=arr(i)+arr2(i);
end
end
