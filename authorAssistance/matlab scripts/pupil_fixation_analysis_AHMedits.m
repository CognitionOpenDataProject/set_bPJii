% reading Tobii output data for fixation duration and fixation count and
% reformatting them, i.e., puts participants from all 3 lists in one
% structure
%
% prerequisite: need to replace all '.' with a ',' for matlab
%
%
% the 9 conditions in the experiment are:
%   1 = supraliminal happy
%   2 = supraliminal fear
%   3 = supraliminal neutral
%   4 = subliminal face happy
%   5 = subliminal face fear
%   6 = subliminal eye happy
%   7 = subliminal eye fear
%   8 = subliminal eye inverted happy
%   9 = subliminal eye inverted fear
%
% Sarah, August 2014


clear all

%addpath 'C:\Users\jessen\Documents\Matlab\matlab_Luebeck\pupil\data';
%datafolder = '\\TS-XL-MGZ\jessen\pupil\final';
addpath '\\tsclient\Set_bPJii\authorAssistance\data\rawdata_pupil';
datafolder = '\\tsclient\Set_bPJii\authorAssistance\data';

% all participants
participants = [8 1 2 3 5 6 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 4];

% all participants who have at least 1 trial per condition, considering
% condition 1,2,4,5
participants_byrows = [3;4;6;7;9;10;11;12;13;15;16;17;18;19;20;21;22;23;24;26;28;29]


%% reformatting for fixation data

conditions = {1,2,3,4,5}
for c = 1:length(conditions)
        % read in data
       fid = fopen([datafolder '\rawdata_fixation\cond' num2str(conditions{c}) '_face1.txt']);

        % data contain fixation duration and fixation count, both for ROI
        % eye and ROI mouth, no ROI and all ROI, and the subfields N, Mean,
        %  and Sum, all separately for the 3 lists
        rawdates = textscan(fid,'%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','TreatAsEmpty','-','HeaderLines',1,'Delimiter','\t');

        fclose(fid);
        
        % take out first column, as it just contains participant number
        longmat = cell2mat(rawdates(:,2:end));
        shortmat = [];
        
        % N, mean,and Sum for Eye ROI, Mouth ROI, no ROI and all ROI
        % amounts to 12 columns per list and item
        for d = 1:6
            
            % its 3 separate lists listed consecutively that we want to
            % collapse (i.e., 1:11,12:23, and 24:35)
            m = [];
            m(:,:,1) = longmat(:,36*d-35:36*d-24);
            m(:,:,2) = longmat(:,36*d-23:36*d-12);
            m(:,:,3) = longmat(:,36*d-11:36*d);
            
            % those are summed to collapse
            shortmat(:,12*d-11:12*d) = nansum(m,3);
                  
            
        end
        
        [parts datas] = size(shortmat);

        
        fid = fopen([datafolder '\preproc_fixation\cond' num2str(conditions{c}) '_face1.txt'], 'w');
                       %take out last row as that's an irrelevant sum
                       for p=1:parts-1
                           for d = 1:datas
                            fprintf(fid,[num2str(shortmat(p,d)) ';']);
                           end
                            fprintf(fid,'\n');
                       end
        fclose(fid);

        
end

%% just supraliminal (condition 1+2)


participants = [8 1 2 3 5 6 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 4];

        condition = 3; % CHANGE HERE to 2 (and 3), for condition 2 and 3 and run again 
        excluded = zeros(length(participants),1);
        included = zeros(length(participants),1);
        eyes = [];
        mouth = [];
        
        % for all 5 faces...
        for f = 1:5
        
        fid = fopen([datafolder '\preproc_fixation\cond' num2str(condition) '_face' num2str(f) '.txt']);

        % columns in dates are: media, mouseresponse
        % data contain fixation duration and fixation count, both for ROI
        % eye and ROI mouth, no ROI and all ROI, and the subfields N, Mean,
        %  and Sum, all separately for the 3 lists
        rawdates = textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','TreatAsEmpty','-','Delimiter',';');

        fclose(fid);
        data = cell2mat(rawdates);
        data = [participants' data];
        
        data = sortrows(data,1);
        
        
        % excluding all trials where participants didn't fixate
        
        for p = 1:length(participants)
           
            if data(p,12)+data(p,9)==0 
                data(p,1:12)=NaN;
                excluded(p) = excluded(p)+1;
            elseif data(p,12)+data(p,9)>0 
                included(p) = included(p)+1;
            end
            
            if data(p,24)+data(p,21)==0
                data(p,13:24)=NaN;
                excluded(p) = excluded(p)+1;
            elseif data(p,24)+data(p,21)>0
                included(p) = included(p)+1;
            end
            
            if data(p,36)+data(p,33)==0
                data(p,25:36)=NaN;
                excluded(p) = excluded(p)+1;
            elseif data(p,36)+data(p,33)>0
                included(p) = included(p)+1;
            end
            
            if data(p,48)+data(p,45)==0
                data(p,37:48)=NaN;
                excluded(p) = excluded(p)+1;
            elseif data(p,48)+data(p,45)>0
                included(p) = included(p)+1;
            end    
            
            if data(p,60)+data(p,57)==0
                data(p,49:60)=NaN;
                excluded(p) = excluded(p)+1;
            elseif data(p,60)+data(p,57)>0
                included(p) = included(p)+1;
            end
            
            if data(p,72)+data(p,69)==0
                data(p,61:72)=NaN;
                excluded(p) = excluded(p)+1;
            elseif data(p,72)+data(p,69)>0
                included(p) = included(p)+1;
            end
        end

        
        
        % on Eye AOI, Mouth AOI, and no AOI
        fixationduration(:,:,f) = [nanmean([data(:,3) data(:,15) data(:,27) data(:,39) data(:,51) data(:,63)],2) nanmean([data(:,6) data(:,18) data(:,30) data(:,42) data(:,54) data(:,66)],2) nanmean([data(:,9) data(:,21) data(:,33) data(:,45) data(:,57) data(:,69)],2)];
        fixationcount(:,:,f) = [nanmean([data(:,1) data(:,13) data(:,25) data(:,37) data(:,49) data(:,61)],2) nanmean([data(:,4) data(:,16) data(:,28) data(:,40) data(:,52) data(:,64)],2) nanmean([data(:,7) data(:,19) data(:,31) data(:,43) data(:,55) data(:,67)],2)];
    
        eyes = [eyes data(:,3) data(:,15) data(:,27) data(:,39) data(:,51) data(:,63)];
        mouth = [mouth data(:,6) data(:,18) data(:,30) data(:,42) data(:,54) data(:,66)];
            
        end
        
%%        
        % STORE the values for cond 1, 2, and 3 as happy, fear, and
        % neutral, respectively (i.e., after having executed the above
        % segment, run one of the following to store values
        
        fixationduration_happy = fixationduration;
        fixationcount_happy = fixationcount;
        eyes_happy = eyes;
        mouth_happy = mouth;
        
        fixationduration_fear = fixationduration;
        fixationcount_fear = fixationcount;
        eyes_fear = eyes;
        mouth_fear = mouth;        
        
        fixationduration_neutral = fixationduration;
        fixationcount_neutral = fixationcount;
        eyes_neutral = eyes;
        mouth_neutral = mouth;        

  % to check which participants to exclude, look at meanvalues and exclude
  % those who have only NaNs in all columns (8 for cond 2 and 5&8 for cond
  % 3)
  
        %% compute mean values
        meanhappy = nanmean(fixationduration_happy,3);
        meanfear = nanmean(fixationduration_fear,3);
        meanneutral = nanmean(fixationduration_neutral,3);
        
        meanvalues = [meanhappy meanfear meanneutral];
        
        % keep only those participants we want in the final sample
        meanvalues = meanvalues(participants_byrows,:)

    
        %% just subliminal (condition 4 and 5)
       
 
    participants = [8 1 2 3 5 6 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 4];

        condition = 5;% CHANGE HERE to 5 and run again
        excluded = zeros(length(participants),1);
        included = zeros(length(participants),1);
        eyes = [];
        mouth = [];
        for f = 1:5
        
        fid = fopen([datafolder '\preproc_fixation\cond' num2str(condition) '_face' num2str(f) '.txt']);

        % columns in dates are: media, mouseresponse
        % data contain fixation duration and fixation count, both for ROI
        % eye and ROI mouth, no ROI and all ROI, and the subfields N, Mean,
        %  and Sum, all separately for the 3 lists
        rawdates = textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','TreatAsEmpty','-','Delimiter',';');

        fclose(fid);
        data = cell2mat(rawdates);
        data = [participants' data];
        
        data = sortrows(data,1);
        
        
        % excluding all trials where participants didn't fixate at least 50 % of the time (i.e., of the 900 ms) 
        
        for p = 1:length(participants)
           
            if data(p,12)+data(p,9)==0
                data(p,1:12)=NaN;
                excluded(p) = excluded(p)+1;
            elseif data(p,12)+data(p,9)>0
                included(p) = included(p)+1;
            end
            
            if data(p,24)+data(p,21)==0
                data(p,13:24)=NaN;
                excluded(p) = excluded(p)+1;
            elseif data(p,24)+data(p,21)>0
                included(p) = included(p)+1;
            end
            
            if data(p,36)+data(p,33)==0
                data(p,25:36)=NaN;
                excluded(p) = excluded(p)+1;
            elseif data(p,36)+data(p,33)>0
                included(p) = included(p)+1;
            end
            
            if data(p,48)+data(p,45)==0
                data(p,37:48)=NaN;
                excluded(p) = excluded(p)+1;
            elseif data(p,48)+data(p,45)>0
                included(p) = included(p)+1;
            end    
            
            if data(p,60)+data(p,57)==0
                data(p,49:60)=NaN;
                excluded(p) = excluded(p)+1;
            elseif data(p,60)+data(p,57)>0
                included(p) = included(p)+1;
            end
            
            if data(p,72)+data(p,69)==0
                data(p,61:72)=NaN;
                excluded(p) = excluded(p)+1;
            elseif data(p,72)+data(p,69)>0
                included(p) = included(p)+1;
            end
        end

        
        
        % on Eye AOI, Mouth AOI, and no AOI
        fixationduration(:,:,f) = [nanmean([data(:,3) data(:,15) data(:,27) data(:,39) data(:,51) data(:,63)],2) nanmean([data(:,6) data(:,18) data(:,30) data(:,42) data(:,54) data(:,66)],2) nanmean([data(:,9) data(:,21) data(:,33) data(:,45) data(:,57) data(:,69)],2)];
        fixationcount(:,:,f) = [nanmean([data(:,1) data(:,13) data(:,25) data(:,37) data(:,49) data(:,61)],2) nanmean([data(:,4) data(:,16) data(:,28) data(:,40) data(:,52) data(:,64)],2) nanmean([data(:,7) data(:,19) data(:,31) data(:,43) data(:,55) data(:,67)],2)];
    
        eyes = [eyes data(:,3) data(:,15) data(:,27) data(:,39) data(:,51) data(:,63)];
        mouth = [mouth data(:,6) data(:,18) data(:,30) data(:,42) data(:,54) data(:,66)];
            
        end
       %% 
        
        % IMPORTANT:
        % let did_baby_look_during_subliminal() run at this point (making 
        % sure that the condition in the other script is the same), as
        % script needs the output to throw out trials during which the baby
        % didn't look during the subliminal face
        
        % for eyes
        
        eyes115 = [eyes(:,1) eyes(:,7) eyes(:,13) eyes(:,19) eyes(:,25)];
        eyes115 = eyes115./(face115(:,2:6)>0);  %face should contains numbers larger than 0 when infant looked during trial. need to divide to get NaNs rather than 0s
        eyes115 = eyes115.*(isfinite(eyes115)); % as dividing by 0 gives inf and not nan, need to be converted to nans
        
        eyes173 = [eyes(:,2) eyes(:,8) eyes(:,14) eyes(:,20) eyes(:,26)];
        eyes173 = eyes173./(face173(:,2:6)>0);
        eyes173 = eyes173.*(isfinite(eyes173));
        
        eyes54 = [eyes(:,3) eyes(:,9) eyes(:,15) eyes(:,21) eyes(:,27)];
        eyes54 = eyes54./(face54(:,2:6)>0);
        eyes54 = eyes54.*(isfinite(eyes54));
          
        eyes63 = [eyes(:,4) eyes(:,10) eyes(:,16) eyes(:,22) eyes(:,28)];
        eyes63 = eyes63./(face63(:,2:6)>0);
        eyes63 = eyes63.*(isfinite(eyes63));
        
        eyes85 = [eyes(:,5) eyes(:,11) eyes(:,17) eyes(:,23) eyes(:,29)];
        eyes85 = eyes85./(face85(:,2:6)>0);
        eyes85 = eyes85.*(isfinite(eyes85));
        
        eyes90 = [eyes(:,6) eyes(:,12) eyes(:,18) eyes(:,24) eyes(:,30)];
        eyes90 = eyes90./(face90(:,2:6)>0);
        eyes90 = eyes90.*(isfinite(eyes90));
        
        
        %% STORE condition 4 and 5 here, respectively
        
        cond4 = [eyes115 eyes173 eyes54 eyes63 eyes85 eyes90];
        cond4mean = nanmean(cond4,2)
        cond4std = nanstd(cond4,0,2)
        
        cond5 = [eyes115 eyes173 eyes54 eyes63 eyes85 eyes90];
        cond5mean = nanmean(cond5,2)
        cond5std = nanstd(cond5,0,2)
        
        
        
        %% for mouth
        mouth115 = [mouth(:,1) mouth(:,7) mouth(:,13) mouth(:,19) mouth(:,25)];
        mouth115 = mouth115./(face115(:,2:6)>0);  %face should contains numbers larger than 0 when infant looked during trial. need to divide to get NaNs rather than 0s
        mouth115 = mouth115.*(isfinite(mouth115)); % as dividing by 0 gives inf and not nan, need to be converted to nans
        
        mouth173 = [mouth(:,2) mouth(:,8) mouth(:,14) mouth(:,20) mouth(:,26)];
        mouth173 = mouth173./(face173(:,2:6)>0);
        mouth173 = mouth173.*(isfinite(mouth173));
        
        mouth54 = [mouth(:,3) mouth(:,9) mouth(:,15) mouth(:,21) mouth(:,27)];
        mouth54 = mouth54./(face54(:,2:6)>0);
        mouth54 = mouth54.*(isfinite(mouth54));
          
        mouth63 = [mouth(:,4) mouth(:,10) mouth(:,16) mouth(:,22) mouth(:,28)];
        mouth63 = mouth63./(face63(:,2:6)>0);
        mouth63 = mouth63.*(isfinite(mouth63));
        
        mouth85 = [mouth(:,5) mouth(:,11) mouth(:,17) mouth(:,23) mouth(:,29)];
        mouth85 = mouth85./(face85(:,2:6)>0);
        mouth85 = mouth85.*(isfinite(mouth85));
        
        mouth90 = [mouth(:,6) mouth(:,12) mouth(:,18) mouth(:,24) mouth(:,30)];
        mouth90 = mouth90./(face90(:,2:6)>0);
        mouth90 = mouth90.*(isfinite(mouth90));
        
        %% STORE condition 4 and 5 here, respectively
        cond4m = [mouth115 mouth173 mouth54 mouth63 mouth85 mouth90];
        cond4mean = [cond4mean nanmean(cond4m,2)]
        cond4std = [cond4std nanstd(cond4m,0,2)]
        
        
        cond5m = [mouth115 mouth173 mouth54 mouth63 mouth85 mouth90];
        cond5mean = [cond5mean nanmean(cond5m,2)]
        cond5std = [cond5std nanstd(cond5m,0,2)]
  
      %%
     % to check which participants to exclude, look at meanvalues and exclude
     % those who have only NaNs in all columns (2,8,14 for cond 4 and
     % 1,5,25,27 for cond 5
     
        cond45 = [cond4mean cond5mean]
                
        % keep only those participants we want in the final sample
        cond45 = cond45(participants_byrows,:)

      
        %% statistics
   
           
        cond1245 = [meanvalues(:,1:2) meanvalues(:,4:5)  cond45];
        
 
         g = [2 2 2];

        names = {'duration','emotion','ROI'}; % slowest rotating factor first
        [efs,F,cdfs,p,eps,dfs,b]=repanova(cond1245,g,names);
        
  