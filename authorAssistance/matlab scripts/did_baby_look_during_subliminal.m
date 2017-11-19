 %% for the subliminal conditions: did the infant look at the face?
 %
 % Excluding participants using this scrip is a bit messy.
 % We need to check whether the infant looked at the face
 % presented during the subliminal condition. face115-face190 contain for
 % all participtants whether they looked at the face during the subliminal
 % period for each face of one trial (since the face was presented 5 times
 % in a row), hence the 5 columns.
 %
 % if we check the sum across all faces (last row), we see that participant
 % 2,9,and 15 didn't look during any face for condition 4 and 1,5, and 28
 % didn't look during any face for condition 5, which means they have to be
 % excluded in any case.
 %
 % for the remaining 21 (note that at this point 4 and 30 has also already
 % been taken out because they have at least one condition with no trial with more
 % than 50 % data available) we need to go and check whether at least one of the
 % trials where the infant looked at the subliminal face also has more than
 % 50 % data time
 %
 % this is true for everyone but participant 26
 % participant 26 only has 1 subliminal face at which he looked for
 % condition 5 (face 115, segment 3). Checking the rawdata excel-file, we
 % see that face 115 was the third face participant 26 saw in this
 % condition.
 % If we now go back and check whether he had more than 50 % of
 % the data in segment 3 in the third trial of condition 5, we see that this was
 % not the case and therefore excluded him.

% clear all

datafolder = '\\TS-XL-MGZ\jessen\pupil\data';

condition = 4 % CHANGE HERE to condition 5

% order of participants in the file exported from Tobii-studio
ordering = [8;1;2;3;5;6;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26;27;28;29;30;4];

        % segment 1...
        fid = fopen([datafolder '\looking\cond' num2str(condition) '_faceroi_sub1.txt']);

        % data contain fixation duration and fixation count, both for ROI
        % eye and ROI mouth, no ROI and all ROI, and the subfields N, Mean,
        %  and Sum
          rawdates = textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','Delimiter',';');

        fclose(fid);
 
    sub1 = [rawdates{1} rawdates{4} rawdates{7} rawdates{10} rawdates{13} rawdates{16}]  ;  
        
    % segment 2..
         fid = fopen([datafolder '\looking\cond' num2str(condition) '_faceroi_sub2.txt']);

      rawdates = textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','Delimiter',';');

        fclose(fid);
        
     sub2 = [rawdates{1} rawdates{4} rawdates{7} rawdates{10} rawdates{13} rawdates{16}]    ;   
 
     %segment 3...
 	fid = fopen([datafolder '\looking\cond' num2str(condition) '_faceroi_sub3.txt']);

      rawdates = textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','Delimiter',';');

        fclose(fid);
        
     sub3 = [rawdates{1} rawdates{4} rawdates{7} rawdates{10} rawdates{13} rawdates{16}]   ;    
        
    % segment 4...
     fid = fopen([datafolder '\looking\cond' num2str(condition) '_faceroi_sub4.txt']);

      rawdates = textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','Delimiter',';');
        fclose(fid);
        
    sub4 = [rawdates{1} rawdates{4} rawdates{7} rawdates{10} rawdates{13} rawdates{16}]  ;     
 
    % segment 5 ...
        fid = fopen([datafolder '\looking\cond' num2str(condition) '_faceroi_sub5.txt']);

      rawdates = textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','Delimiter',';');

        fclose(fid);
        
    sub5 = [rawdates{1} rawdates{4} rawdates{7} rawdates{10} rawdates{13} rawdates{16}] ;     
 
    
    
 face115 = [ordering sub1(:,1) sub2(:,1) sub3(:,1) sub4(:,1) sub5(:,1) ];
 
 face115 = sortrows(face115,1)
 
 face173 = [ordering sub1(:,2) sub2(:,2) sub3(:,2) sub4(:,2) sub5(:,2) ];
 
 face173 = sortrows(face173,1)
 
 face54 = [ordering sub1(:,3) sub2(:,3) sub3(:,3) sub4(:,3) sub5(:,3) ];
 
 face54 = sortrows(face54,1)
 
 face63 = [ordering sub1(:,4) sub2(:,4) sub3(:,4) sub4(:,4) sub5(:,4) ];
 
 face63 = sortrows(face63,1)
 
 face85 = [ordering sub1(:,5) sub2(:,5) sub3(:,5) sub4(:,5) sub5(:,5) ];
 
 face85 = sortrows(face85,1)
 
 face90 = [ordering sub1(:,6) sub2(:,6) sub3(:,6) sub4(:,6) sub5(:,6) ];
 
 face90 = sortrows(face90,1)

 % sum across all faces to see whether some did not look during any of the
 % subliminal times
 [face90(:,1)  face115(:,2:end)+face173(:,2:end)+face54(:,2:end)+face63(:,2:end)+face85(:,2:end)+face90(:,2:end)]