% reads in Tobii data for pupil dilation and analyzes them
%
% Preparation:
% * create excel-sheet with only the relevant columns (i.e., timestamp,
% media, left pupil, right pupil)
% * export to txt-file
% * replace all comma-seperators in numbers with '.'
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
%   note that condition 6-9 are not relevant to the data published in
%   Cognition
%
% Sarah, April 2014

clear all

addpath '\\tsclient\Set_bPJii\authorAssistance\data';
datafolder = '\\tsclient\Set_bPJii\authorAssistance\data';

participants = {1,2,3,4,5,6,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30}
% note that vp 7 doesn't have any data because he was too fussy

%% AHM EXCLUDED
% Commenting out this pre-processing section, as my attempts to replicate the above 
% transformation instructions in R did not work. 

% %% reformat data
% % read in data
% 
% counter = 0;
% counterall = 0;
% 
% for vp = 1:length(participants)
%      disp(['Now doing participant ' num2str(participants{vp}) '!']);   
%     if participants{vp} < 10
%         fid = fopen([datafolder '\rawdata_pupil\txt\pupil_infant_0' num2str(participants{vp}) '.txt']);
%     else
%         fid = fopen([datafolder '\rawdata_pupil\txt\pupil_infant_' num2str(participants{vp}) '.txt']);
%     end;
% 
% % columns in dates are: media, timestamp, left pupil, right pupil
% rawdates = textscan(fid,'%s%d%f%f','HeaderLines',1,'Delimiter','\t');
% 
% fclose(fid);
% 
% % create structure for data
% % one field for each condition (1-9)
% % each with the subfields
% %   trials = number of trials completed
% %   datal = separately for each trial the data for the left eye
% %   datar = separately for each trial the data for the right eye
% %   datam = mean data for each trail across both eyes
% 
% clear pupildates
% pupildates = cell(1);
% % counter for the trials in each condition
% c1 = 1;
% c2 = 1;
% c3 = 1;
% c4 = 1;
% c5 = 1;
% c6 = 1;
% c7 = 1;
% c8 = 1;
% c9 = 1;
% 
% i=1;
% 
% % sorts dates according to conditions (1-9) and takes mean pupil size from
% % left and right eye, if both are available, left or right if only one is
% % available, and NaN if neither eye is available
% while i<length(rawdates{2})
% 
%     if  ~isempty(rawdates{1}{i}) && strcmp(rawdates{1}{i}(1),'1')
%         n=1;
%         while ~isempty(rawdates{1}{i}) && strcmp(rawdates{1}{i}(1),'1')
%             pupildates{1}.datal(c1,n) = rawdates{3}(i);
%             pupildates{1}.datar(c1,n) = rawdates{4}(i);
%             pupildates{1}.time(c1,n) = rawdates{2}(i+1)-rawdates{2}(i-n);
%             if ~isnan(rawdates{3}(i)) && ~isnan(rawdates{4}(i))
%                 counterall = counterall+1;
%                 pupildates{1}.datam(c1,n) = mean([rawdates{3}(i),rawdates{4}(i)]);
%             elseif isnan(rawdates{3}(i)) && ~isnan(rawdates{4}(i))
%                 counter = counter+1;
%                 pupildates{1}.datam(c1,n) = rawdates{4}(i);
%             elseif isnan(rawdates{4}(i)) && ~isnan(rawdates{3}(i))
%                 counter = counter+1;
%                 pupildates{1}.datam(c1,n) = rawdates{3}(i);
%             else
%                 pupildates{1}.datam(c1,n) = NaN;
%             end            
%             i=i+1;
%             n = n+1;
%         end
%         pupildates{1}.files{c1} = rawdates{1}(i-1);
%         c1 = c1+1;
%     elseif ~isempty(rawdates{1}{i}) && strcmp(rawdates{1}{i}(1),'2')
%         n=1;
%         while ~isempty(rawdates{1}{i}) && strcmp(rawdates{1}{i}(1),'2')
%             pupildates{2}.datal(c2,n) = rawdates{3}(i);
%             pupildates{2}.datar(c2,n) = rawdates{4}(i);
%             pupildates{2}.time(c2,n) = rawdates{2}(i+1)-rawdates{2}(i-n);
%             if ~isnan(rawdates{3}(i)) && ~isnan(rawdates{4}(i))
%                 counterall = counterall+1;
%                 pupildates{2}.datam(c2,n) = mean([rawdates{3}(i),rawdates{4}(i)]);
%             elseif isnan(rawdates{3}(i)) && ~isnan(rawdates{4}(i))
%                 counter = counter+1;
%                 pupildates{2}.datam(c2,n) = rawdates{4}(i);
%             elseif isnan(rawdates{4}(i)) && ~isnan(rawdates{3}(i))
%                 counter = counter+1;
%                 pupildates{2}.datam(c2,n) = rawdates{3}(i);
%             else
%                 pupildates{2}.datam(c2,n) = NaN;
%             end
%             i=i+1;
%             n = n+1;
%         end
%         pupildates{2}.files{c2} = rawdates{1}(i-1);
%         c2 = c2+1;
%     elseif ~isempty(rawdates{1}{i}) && strcmp(rawdates{1}{i}(1),'3')
%         n=1;
%         while ~isempty(rawdates{1}{i}) && strcmp(rawdates{1}{i}(1),'3')
%             pupildates{3}.datal(c3,n) = rawdates{3}(i);
%             pupildates{3}.datar(c3,n) = rawdates{4}(i);
%             pupildates{3}.time(c3,n) = rawdates{2}(i+1)-rawdates{2}(i-n);
%             if ~isnan(rawdates{3}(i)) && ~isnan(rawdates{4}(i))
%                 pupildates{3}.datam(c3,n) = mean([rawdates{3}(i),rawdates{4}(i)]);
%             elseif isnan(rawdates{3}(i)) && ~isnan(rawdates{4}(i))
%                 pupildates{3}.datam(c3,n) = rawdates{4}(i);
%             elseif isnan(rawdates{4}(i)) && ~isnan(rawdates{3}(i))
%                 pupildates{3}.datam(c3,n) = rawdates{3}(i);
%             else
%                 pupildates{3}.datam(c3,n) = NaN;
%             end
%             i=i+1;
%             n = n+1;
%         end
%         pupildates{3}.files{c3} = rawdates{1}(i-1);
%         c3 = c3+1;
%     elseif ~isempty(rawdates{1}{i}) && strcmp(rawdates{1}{i}(1),'4')
%         n=1;
%         while ~isempty(rawdates{1}{i}) && strcmp(rawdates{1}{i}(1),'4')
%             pupildates{4}.datal(c4,n) = rawdates{3}(i);
%             pupildates{4}.datar(c4,n) = rawdates{4}(i);
%             pupildates{4}.time(c4,n) = rawdates{2}(i+1)-rawdates{2}(i-n);
%             if ~isnan(rawdates{3}(i)) && ~isnan(rawdates{4}(i))
%                 counterall = counterall+1;
%                 pupildates{4}.datam(c4,n) = mean([rawdates{3}(i),rawdates{4}(i)]);
%             elseif isnan(rawdates{3}(i)) && ~isnan(rawdates{4}(i))
%                 counter = counter+1;
%                 pupildates{4}.datam(c4,n) = rawdates{4}(i);
%             elseif isnan(rawdates{4}(i)) && ~isnan(rawdates{3}(i))
%                 counter = counter+1;
%                 pupildates{4}.datam(c4,n) = rawdates{3}(i);
%             else
%                 pupildates{4}.datam(c4,n) = NaN;
%             end
%             i=i+1;
%             n = n+1;
%         end
%         pupildates{4}.files{c4} = rawdates{1}(i-1);
%         c4 = c4+1;        
%     elseif ~isempty(rawdates{1}{i}) && strcmp(rawdates{1}{i}(1),'5')
%         n=1;
%         while ~isempty(rawdates{1}{i}) && strcmp(rawdates{1}{i}(1),'5')
%             pupildates{5}.datal(c5,n) = rawdates{3}(i);
%             pupildates{5}.datar(c5,n) = rawdates{4}(i);
%             pupildates{5}.time(c5,n) = rawdates{2}(i+1)-rawdates{2}(i-n);
%             if ~isnan(rawdates{3}(i)) && ~isnan(rawdates{4}(i))
%                 counterall = counterall+1;
%                 pupildates{5}.datam(c5,n) = mean([rawdates{3}(i),rawdates{4}(i)]);
%             elseif isnan(rawdates{3}(i)) && ~isnan(rawdates{4}(i))
%                 counter = counter+1;
%                 pupildates{5}.datam(c5,n) = rawdates{4}(i);
%             elseif isnan(rawdates{4}(i)) && ~isnan(rawdates{3}(i))
%                 counter = counter+1;
%                 pupildates{5}.datam(c5,n) = rawdates{3}(i);
%             else
%                 pupildates{5}.datam(c5,n) = NaN;
%             end
%             i=i+1;
%             n = n+1;
%         end
%         pupildates{5}.files{c5} = rawdates{1}(i-1);
%         c5 = c5+1;
%     elseif ~isempty(rawdates{1}{i}) && strcmp(rawdates{1}{i}(1),'6')
%         n=1;
%         while ~isempty(rawdates{1}{i}) && strcmp(rawdates{1}{i}(1),'6')
%             pupildates{6}.datal(c6,n) = rawdates{3}(i);
%             pupildates{6}.datar(c6,n) = rawdates{4}(i);
%             pupildates{6}.time(c6,n) = rawdates{2}(i+1)-rawdates{2}(i-n);
%             if ~isnan(rawdates{3}(i)) && ~isnan(rawdates{4}(i))
%                 pupildates{6}.datam(c6,n) = mean([rawdates{3}(i),rawdates{4}(i)]);
%             elseif isnan(rawdates{3}(i)) && ~isnan(rawdates{4}(i))
%                 pupildates{6}.datam(c6,n) = rawdates{4}(i);
%             elseif isnan(rawdates{4}(i)) && ~isnan(rawdates{3}(i))
%                 pupildates{6}.datam(c6,n) = rawdates{3}(i);
%             else
%                 pupildates{6}.datam(c6,n) = NaN;
%             end
%             i=i+1;
%             n = n+1;
%         end
%         pupildates{6}.files{c6} = rawdates{1}(i-1);
%         c6 = c6+1;
%     elseif ~isempty(rawdates{1}{i}) && strcmp(rawdates{1}{i}(1),'7')
%         n=1;
%         while ~isempty(rawdates{1}{i}) && strcmp(rawdates{1}{i}(1),'7')
%             pupildates{7}.datal(c7,n) = rawdates{3}(i);
%             pupildates{7}.datar(c7,n) = rawdates{4}(i);
%             pupildates{7}.time(c7,n) = rawdates{2}(i+1)-rawdates{2}(i-n);
%             if ~isnan(rawdates{3}(i)) && ~isnan(rawdates{4}(i))
%                 pupildates{7}.datam(c7,n) = mean([rawdates{3}(i),rawdates{4}(i)]);
%             elseif isnan(rawdates{3}(i)) && ~isnan(rawdates{4}(i))
%                 pupildates{7}.datam(c7,n) = rawdates{4}(i);
%             elseif isnan(rawdates{4}(i)) && ~isnan(rawdates{3}(i))
%                 pupildates{7}.datam(c7,n) = rawdates{3}(i);
%             else
%                 pupildates{7}.datam(c7,n) = NaN;
%             end
%             i=i+1;
%             n = n+1;
%         end
%         pupildates{7}.files{c7} = rawdates{1}(i-1);
%         c7 = c7+1;
%     elseif ~isempty(rawdates{1}{i}) && strcmp(rawdates{1}{i}(1),'8')
%         n=1;
%         while ~isempty(rawdates{1}{i}) && strcmp(rawdates{1}{i}(1),'8')
%             pupildates{8}.datal(c8,n) = rawdates{3}(i);
%             pupildates{8}.datar(c8,n) = rawdates{4}(i);
%             pupildates{8}.time(c8,n) = rawdates{2}(i+1)-rawdates{2}(i-n);
%             if ~isnan(rawdates{3}(i)) && ~isnan(rawdates{4}(i))
%                 pupildates{8}.datam(c8,n) = mean([rawdates{3}(i),rawdates{4}(i)]);
%             elseif isnan(rawdates{3}(i)) && ~isnan(rawdates{4}(i))
%                 pupildates{8}.datam(c8,n) = rawdates{4}(i);
%             elseif isnan(rawdates{4}(i)) && ~isnan(rawdates{3}(i))
%                 pupildates{8}.datam(c8,n) = rawdates{3}(i);
%             else
%                 pupildates{8}.datam(c8,n) = NaN;
%             end
%             i=i+1;
%             n = n+1;
%         end
%         pupildates{8}.files{c8} = rawdates{1}(i-1);
%         c8 = c8+1;
%     elseif ~isempty(rawdates{1}{i}) && strcmp(rawdates{1}{i}(1),'9')
%         n=1;
%         while ~isempty(rawdates{1}{i}) && strcmp(rawdates{1}{i}(1),'9')
%             pupildates{9}.datal(c9,n) = rawdates{3}(i);
%             pupildates{9}.datar(c9,n) = rawdates{4}(i);
%             pupildates{9}.time(c9,n) = rawdates{2}(i+1)-rawdates{2}(i-n);
%             if ~isnan(rawdates{3}(i)) && ~isnan(rawdates{4}(i))
%                 pupildates{9}.datam(c9,n) = mean([rawdates{3}(i),rawdates{4}(i)]);
%             elseif isnan(rawdates{3}(i)) && ~isnan(rawdates{4}(i))
%                 pupildates{9}.datam(c9,n) = rawdates{4}(i);
%             elseif isnan(rawdates{4}(i)) && ~isnan(rawdates{3}(i))
%                 pupildates{9}.datam(c9,n) = rawdates{3}(i);
%             else
%                 pupildates{9}.datam(c9,n) = NaN;
%             end
%             i=i+1;
%             n = n+1;
%         end
%         pupildates{9}.files{c9} = rawdates{1}(i-1);
%         c9 = c9+1;
%     else
%         i=i+1;
%     end
%     
% end
% 
% for i = 1:9
%     
%     % matlab automatically fills trials with less sampling points up with
%     % zeros at the end to match length of trials with maximal sampling
%     % points. this messes up the average. therefore change the zeros to NaN
%     % (note that zeros should only occur at the end, as pupil can't have a
%     % natural size of 0).
%     [trialnum longest] = size(pupildates{i}.datam);
%     pupildates{i}.time = double(pupildates{i}.time);
%     for t=1:trialnum
%         
%         for l = 1:longest
%             if pupildates{i}.datam(t,l)==0
%                 pupildates{i}.datam(t,l)=NaN;
%                 pupildates{i}.time(t,l)=NaN;
%             end
%         end
%         
%     end
%     
%     pupildates{i}.mean = nanmean(pupildates{i}.datam);
% end
% 
% save ([datafolder '\preproc_pupil\preprocessed' num2str(participants{vp}) '.mat'], 'pupildates');    
% 
% end
% 
% %% split into segments
% % NOTE: if you get "Improper assignment with rectangular empty matrix.",
% % that is because the participant doesn't have enought timepoints to
% % determine end and start point for some subpart. Check how many starting
% % points he has (how many entries are in "starting"), adjust subdata-loop accordingly and let it run. Then
% % adjust c = 1:9 to start with the next condition (e.g., c=6:9), run the
% % rest, and save. Remember to put correct values back in for both loops.
% 
% 
% for p = 1:length(participants)
%     clear data
%      disp(['Now doing participant ' num2str(participants{p}) '!']);  
%      clear subdata datar subtime
% load ([datafolder '\preproc_pupil\preprocessed' num2str(participants{p}) '.mat']); 
% for c=1:5
% 
%     
% % splits recording of one video (i.e., 5 repetitions of stimuli) into 5 subparts    
% [l w] = size(pupildates{c}.time)
% for t=1:l
% 
%     clear starting ending
%     starting(1) = min(find(pupildates{c}.time(t,:)>=0));
%     ending(1) = max(find(pupildates{c}.time(t,:)<=2300));
%     starting(2) = min(find(pupildates{c}.time(t,:)>=2600));
%     ending(2) = max(find(pupildates{c}.time(t,:)<=4600));
%     starting(3) = min(find(pupildates{c}.time(t,:)>=4900));
%     ending(3) = max(find(pupildates{c}.time(t,:)<=6900));
%     starting(4) = min(find(pupildates{c}.time(t,:)>=7200));
%     ending(4) = max(find(pupildates{c}.time(t,:)<=9200));
%     starting(5) = min(find(pupildates{c}.time(t,:)>=9500));
%     ending(5) = max(find(pupildates{c}.time(t,:)<=11500));
%     
%     % here is were sub needs to be changed (see above)
%     for sub = 1:5
%         subdata{c,t,sub}=pupildates{c}.datam(t,starting(sub):ending(sub));
%         subtime{c,t,sub}=pupildates{c}.time(t,starting(sub):ending(sub));
%     end
% end
%     [cond tnum segs] = size(subdata);
%    
%     % convert to timeseries objects
%     for i=1:tnum
%        
%         for s=1:segs
%          if sum(isfinite(subdata{c,i,s}))/length(subdata{c,i,s}) >=.5   
% 
%             
%            data(c,i,s) = nanmean(subdata{c,i,s});
%            
% 
%          end
%             
%         end
%         
%     end
% 
% end
% save ([datafolder '\pupil_seg' num2str(participants{p}) '.mat'], 'data');    
% 
% 
% end
% %% check that at least 50 % datapoints are there
% % (value should be larger 0.5.)
% % if for one relevant condition, no segment has more than 50 %  data points,
% % participant is excluded
% % this way, we excluded participant 2,4,5,9,and 30
% 
% participants = {1,2,3,4,5,6,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30}
% 
% p=25;
% c=5;
% 
% load([datafolder '\pupil_segments\segs' num2str(participants{p}) '.mat']);
% 
% t = 4; %miniblock considered
% 
% for s=1:5
%     sum(isfinite(subdata{c,t,s}))/length(subdata{c,t,s})
% end

% at this point, you probably also want to check who else needs to be
% excluded because the baby didn't look during the presentation of the
% subliminal face in condition 4 and 5. This is done with (and explained
% in) did_baby_look_during_subliminal.m

%% statistics
% AHM: This is where I started running

% all participants with at least one trial per condition
participants = {3,6,8,10,11,12,13,14,16,17,18,19,20,21,22,23,24,25,27,29}

clear condmean
%AHM added to capture number of trials per participant
numtrials = [];

% first, compute mean values for condition 1-3, as we don't need to bother
% with whether the baby looked at the subliminal face or not
for p = 1:length(participants)

   load ([datafolder '\preproc_segments\segs' num2str(participants{p}) '.mat']);     
   
   for c = 1:3
    condy=[];
      [cond trial subpart] = size(data(c,:,:));
   
      %AHM: append with number of trials for conditions 1 and 2
    if (c < 3)  
      numtrials = [numtrials trial];
    end  
      
      % since we analyze over segments, create a list containing all trials
      % and segments
      counter=1;
      for t = 1:trial
          for s = 1:5
              if not(isempty(data(c,t,s)))
                condy(counter,:) = data(c,t,s);
                counter=counter+1;
                
              end
          end
       
      end
     
      % this criterion was used to exclude outliers with implausible values
      % (pupil size below 0 or above 5)
      condy(condy<=0)=NaN;
      condy(condy>=5)=NaN;

   
      % compute mean over remaining data
      [t nu] = size(condy);
       trialnum(c,p)=sum(isfinite(condy)); 
     
      if t>1
          condmean(c,p,:) = nanmean(condy);
        
      else 
          condmean(c,p,:)=condy;
      
      end
   end
end


% second we compute the mean for condition 4 and 5
for p = 1:length(participants)

    % contains in a summarized fashion what we also get from did_baby_look_during_subliminal.m,
    % namely the information whether a given baby looked at the subliminal
    % face during condition 4 and 5 (data structure contained is called
    % "looky")
    load ([datafolder '\looking\exp2faceroi' num2str(participants{p}) '.mat']);  

    load ([datafolder '\preproc_segments\segs' num2str(participants{p}) '.mat']);     


    c=4;
    condy=[];
      [cond trial subpart] = size(data(c,:,:));

      %AHM: append with number of trials
      numtrials = [numtrials trial];
      
      % since we analyze over segments, create a list containing all trials
      % and segments in which the baby also looked during subliminal
      counter=1;
      for t = 1:trial
          for s = 1:5
              if not(isempty(data(c,t,s))) && looky(1,t,s) == 1
                condy(counter,:) = data(c,t,s);
                counter=counter+1;
                
              end
          end
       
      end
     
      condy(condy<=0)=NaN;
      condy(condy>=5)=NaN;

   
      [t nu] = size(condy);
      trialnum(c,p)=sum(isfinite(condy));
      if t>1
          condmean(c,p,:) = nanmean(condy);
        
      else 
          condmean(c,p,:)=condy;
      
      end
      
      
      
      c=5;
     condy=[];
      [cond trial subpart] = size(data(c,:,:));

      %AHM: append with number of trials
      numtrials = [numtrials trial];
      
     counter=1;
      for t = 1:trial
          for s = 1:5
              if not(isempty(data(c,t,s))) && looky(2,t,s) == 1
                condy(counter,:) = data(c,t,s);
                counter=counter+1;
                
              end
          end
       
      end
     
      condy(condy<=0)=NaN;
      condy(condy>=5)=NaN;

   
      [t nu] = size(condy);
      trialnum(c,p)=sum(isfinite(condy));
      if t>1
          condmean(c,p,:) = nanmean(condy);
        
      else 
          condmean(c,p,:)=condy;
      
      end
      
   
end

% average over timecourse
staty = nanmean(condmean,3);
staty = staty';

% throw out condition 3 (neutral), which isn't included in the stats
staty = [staty(:,1:2) staty(:,4:5)]

% divide by mean to reduce within-subject variance
staty2 = staty./[mean(staty,2) mean(staty,2) mean(staty,2) mean(staty,2)];

%AHM write out as csv
csvwrite("meanpupilsizebycondition.csv", staty)

%AHM: Using numtrials, take the mean & standard deviation
size(numtrials)
mean(numtrials)
std(numtrials)

%From author Jan 2018 email:
%First, need to get rid of condition 3
trialnum(3,:) = []
mean(mean(trialnum))
std(mean(trialnum,2))
std(mean(trialnum))

%However, it's unclear whether condition referred to only supra/subliminal 
%In this case, need to sum number of trials for c1 and c2, and then for c4
%and c5
supralimtrials = numtrials(1:20) + numtrials(21:40);
sublimtrials = numtrials(41:60) + numtrials(61:80);
totnumtrials = [supralimtrials sublimtrials];

mean(totnumtrials)
std(totnumtrials)



% compute repeated measures ANOVA
g = [2 2];
names = {'duration','emotion'}; % slowest rotating factor first
[efs,F,cdfs,p,eps,dfs,b]=repanova(staty2,g,names);
