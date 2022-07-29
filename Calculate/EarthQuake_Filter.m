clear;clc;close all

%% constants
% name constans
mag = 'M7';
addrHead = ['data\',mag,'_'];
fileHead = '\ionPrf_prov1_';
% flag
inRange = 0;
% Range Ring
theta = 0:0.01:2*pi;
ringX = 1.5*cos(theta);
ringY = 1.5*sin(theta);

%% read earthquake data want to search for
EQData = readmatrix([mag,'.yyyy.ddd.hh.mm.ss.lat.lon.dep.mag.csv']);
serachYear = EQData(1,1);
serachDay = EQData(1,2);

%% color list
colorCount = 1;
colorList = {'#0072BD','#D95319','#7E2F8E','#77AC30'};
%colorList = {'r','b','c','g'};

%% read list one by one
for count = 1:1%length(EQData(:,1))
    %% current path
    
    if serachDay(count) < 100
        if serachDay(count) < 10
            path = [addrHead, char(string(serachYear(count))), fileHead, char(string(serachYear(count))), '_00', char(string(serachDay(count))), '\'];
        else
            path = [addrHead, char(string(serachYear(count))), fileHead, char(string(serachYear(count))), '_0', char(string(serachDay(count))), '\'];
        end
    else
        path = [addrHead, char(string(serachYear(count))), fileHead, char(string(serachYear(count))), '_', char(string(serachDay(count))), '\'];
    end
    
    %% time search range (min)
    hourShift = 4;
    time = hourShift*60+60;%minute
    %
    hm = zeros(time,2);
    curr_searchTime = strings([time,2]);
    for t=1:time
        %% list[double] about each minute
        hm(t,1) = EQData(count,3)-hourShift;
        hm(t,2) = EQData(count,4)+t-1;
        if hm(t,2)>59
            minAdd = mod(hm(t,2),60);
            hourAdd = floor(hm(t,2)/60);
            hm(t,1) = EQData(count,3)-hourShift+hourAdd;
            hm(t,2) = minAdd;
        end
        %% [double] to [char] list (3:1 ==> 03:01)
        if hm(t,2)<10
            curr_searchTime{t} = [char(string(hm(t,1))),'.0',char(string(hm(t,2)))];
        else
            curr_searchTime{t} = [char(string(hm(t,1))),'.',char(string(hm(t,2)))];
        end
        if hm(t,1)<10
            curr_searchTime{t} = ['0',curr_searchTime{t}];
        end
    end
    
    %% select file name in time range
    % [double] to [char] and 3 digits
    serachYearChar = char(string(serachYear(count)));
    if serachDay(count) < 100
        if serachDay(count) < 10
            serachDayChar = ['00',char(string(serachDay(count)))];
        else
            serachDayChar = ['0',char(string(serachDay(count)))];
        end
    else
        serachDayChar = char(string(serachDay(count)));
    end
    
    timeExpandPathName1 = [];
    % make a search list about name
    for hourCount = 1:time
        currDir = dir([path,'ionPrf*',serachYearChar,'.',serachDayChar,'.',curr_searchTime{hourCount},'*']);
        timeExpandPathName1 = [timeExpandPathName1,struct2cell(currDir)];
    end
    % get first line
    for i=1:length(timeExpandPathName1)
        timeExpandPathName{i} = timeExpandPathName1{1,i};
    end
    
    
    %% image number
    charNum = char(string(count));
    if count > 10
        if count > 100
            if count > 1000
                return;
            else
                imageNum = ['-0',charNum];
            end
        else
            imageNum = ['-00',charNum];
        end
    else
        imageNum = ['-000',charNum];
    end
    
    %% read data in time range
    if exist('timeExpandPathName')
        %% EQ Data
        EQlong = EQData(count,7);
        EQlati = EQData(count,6);
        EQtime = [char(string(EQData(count,3))),'h.',char(string(EQData(count,4))),'m'];
        
        %% plot a world map
        figure(1);
        axis([-180,180,-90,90]);grid on;
        geoshow('landareas.shp','FaceColor','green');hold on;
        set(gca,'DataAspectRatio',[1 1 1]);hold on;
        
        %% plot EarthQuake Coordinate
        imageName = ['Year-',serachYearChar,'-Day-',serachDayChar,'(',mag,'+)'];
        title(imageName);xlabel('Longitude [deg]');ylabel('Latitude [deg]');
        scatter(EQlong,EQlati,100,'filled','p','red','DisplayName',['EqrthQuake: ',EQtime]);hold on;
        
        %% plot a ring
        plot(ringX+EQlong, ringY+EQlati,'red','DisplayName','Range');
        
        for j=1:length(timeExpandPathName)
            
            %% read lat.&lon.
            GEO_lat = ncread([path,timeExpandPathName{j}],'GEO_lat');
            GEO_lon = ncread([path,timeExpandPathName{j}],'GEO_lon');
            data = [GEO_lat,GEO_lon];
            
            %% in Range flag
            for ii = 1:length(data)
                if sqrt( (data(ii,1)-EQlati)^2  + (data(ii,2)-EQlong)^2  ) <= 1.5
                    inRange = 1;
                    break;
                end
            end
            
            %% in Range plot
            if inRange == 1
                
                disp(timeExpandPathName{1,j});
                hhmm = timeExpandPathName{1,j};
                hh = hhmm(22:23);
                mm = hhmm(25:26);
                curr_hhmm = [hh,'h.',mm,'m'];
                
                %read netCDF file
                MSL_alt = ncread([path,timeExpandPathName{j}],'MSL_alt');
                TEC_cal = ncread([path,timeExpandPathName{j}],'TEC_cal');
                ELEC_dens = ncread([path,timeExpandPathName{j}],'ELEC_dens');
                
                % plot
                f1 = figure(1);legend;
                f1.Position = [100 100 600 600];
                axis([-180,180,-90,90]);
                scatter(data(:,2),data(:,1),30,'.','MarkerEdgeColor',colorList{colorCount},'MarkerFaceColor',colorList{colorCount},'DisplayName',curr_hhmm);hold on;
                axis([EQlong-5,EQlong+5,EQlati-5,EQlati+5]);
                
                
                f2 = figure(2);legend;
                f2.Position = [100 100 600 600];
                plot(TEC_cal,MSL_alt,'LineWidth',2,'Color',colorList{colorCount},'DisplayName',curr_hhmm);hold on;
                title(imageName);xlabel('Total Electronic Content [TECU]');ylabel('Altitude [km]');
                
                f3 = figure(3);legend;
                f3.Position = [100 100 600 600];
                plot(ELEC_dens,MSL_alt,'LineWidth',2,'Color',colorList{colorCount},'DisplayName',curr_hhmm);hold on;
                title(imageName);xlabel('Electron density [el/cm^3]');ylabel('Altitude [km]');
                
                inRange = 0;
                colorCount = colorCount+1;
            end
        end
        %% clear var. & save print
        %     figure(1);
        %     axis([-180,180,-90,90]);
        %     saveas(gcf,[imageName,imageNum,'.png']);
        %     axis([EQlong-5,EQlong+5,EQlati-5,EQlati+5]);
        %     saveas(gcf,['Detail-',imageName,imageNum,'.png']);
        %clf(f1);
        %     figure(2);
        %     saveas(gcf,['TEC-ALT-',imageName,imageNum,'.png']);
        %clf(f2);
        %     figure(3);
        %     saveas(gcf,['ELEC-ALT-',imageName,imageNum,'.png']);
        %clf(f3);
        
        clear data GEO_lat GEO_lon;
        clear hourCount i imageName j path  timeExpandPathName1 t;
    end
end