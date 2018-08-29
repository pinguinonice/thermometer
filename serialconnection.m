% reads temperatur and time from UART serial
% graphs values and writes them to file.csv

% initialize variable
clc
clear all
close all

time=[];
Temperatur=[];

% serial connection
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end
ports=seriallist
sObject=serial(ports(3))%<- change for your port;
fopen(sObject)


fileID = fopen('log.csv','w');
fprintf(fileID,'Time[ms],Temperature[C],Date\n');
fprintf('Time[ms],Temperature[C],Date\n');

starttime=now; 

f=figure;
while true
    
    tTstring=fgets(sObject);
    tT=str2num(tTstring);
    
    time(end+1)=tT(1);
    
    Temperatur(end+1)=tT(2);
    
    datestring=datestr(starttime+(time(end)-time(1))/1000/60/60/24)
    fprintf(fileID,strcat('%f,%f,',datestring,'\n'),time(end),Temperatur(end));
    fprintf(strcat('%f,%f,',datestring,'\n'),time(end),Temperatur(end));
    
    
    plot(time,Temperatur);
    drawnow
    
    pause(1)
    if ~ishandle(f)
        return
    end
end
fclose(sObject)

xlswrite('filename.xls',[time' Temperatur'])