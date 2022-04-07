%% get directory
clear;
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

%% ---------------------------Training---------------------------
rhad=mean(tr(training_files_had));
rhade=mean(tr(training_files_hade));
rhard=mean(tr(training_files_hard));
rhead = mean(tr(training_files_head));
rheard=mean(tr(training_files_heard));
rheed=mean(tr(training_files_heed));
rhid=mean(tr(training_files_hid));
rhide=mean(tr(training_files_hide));
rhoard=mean(tr(training_files_hoard));
rhod=mean(tr(training_files_hod));
rhood=mean(tr(training_files_hood));
rhudd=mean(tr(training_files_hudd));
rwhod=mean(tr(training_files_whod));
%% ---------------------------Testing---------------------------
training_array = [rhad rhade rhard rhead rheard rheed rhid rhide rhoard rhod rhood rhudd rwhod];
text = ["had" "hade" "hard" "head" "heard" "heed" "hid" "hide" "hoard" "hod" "hood" "hudd" "whod"];
count=0;
count=ts("had",testing_files_had,text,training_array,count);
count=ts("hade",testing_files_hade,text,training_array,count);
count=ts("hard",testing_files_hard,text,training_array,count);
count=ts("head",testing_files_head,text,training_array,count);
count=ts("heard",testing_files_heard,text,training_array,count);
count=ts("heed",testing_files_heed,text,training_array,count);
count=ts("hid",testing_files_hid,text,training_array,count);
count=ts("hide",testing_files_hide,text,training_array,count);
count=ts("hoard",testing_files_hoard,text,training_array,count);
count=ts("hod",testing_files_hod,text,training_array,count);
count=ts("hood",testing_files_hood,text,training_array,count);
count=ts("hudd",testing_files_hudd,text,training_array,count);
count=ts("whod",testing_files_whod,text,training_array,count);
%% print success rate
 fprintf('success rate =%2.2f%%\n',100.*count./39);
 %% function to get the close number of a givven array 
function [value, index]=closest (num, arr)
    curr = 1;
    val=arr(1);
    for i =1:length(arr)
        if abs (num - arr(i)) < abs (num - val)
            curr = i;
            val=arr(i);
        end
    end
    index= curr;
    value=val;
end
function [y]=preproc(y,fs)
    y=y-mean(y);
    hd = design(fdesign.bandpass('N,Fc1,Fc2',10,220,3220,fs));
    y = filter(hd,y);         
    y=sum(y.^2);
end
function [arr]= tr(file)
arr= [];
for i = 1:length(file)
    file_path = strcat(file(i).folder,'\',file(i).name);% get the file path with name
    [y, fs] = audioread(file_path); % read the audio file
    y=preproc(y,fs);
    arr = [arr y];
end
end
function [count] =ts(s,file,text,arr,count)
for i = 1:length(file)
    file_path = strcat(file(i).folder,'\',file(i).name);
    [y,fs] = audioread(file_path);
    f=preproc(y,fs);
    [val, index]=closest(f,arr) ;
    if strcmp(text(index),s)
        fprintf('Test file %s[%d]#classified  %s \n',s,i,text(index));
        count= count+1;
    else
        fprintf('Test file %s[%d] # classified  %s \n',s,i,text(index));
    end
end
end