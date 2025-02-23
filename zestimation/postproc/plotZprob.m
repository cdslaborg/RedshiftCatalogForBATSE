rateModelList = ["H06","L08","B10","M14","M17","F18"];
for rateModel = rateModelList

    %disp("processing rate model " + rateModel)

    buildDir = "D:\Dropbox\Projects\20181213_BatseLgrbRedshift\git\zestimation\build\winx64\intel\19.0.4.245\release\static\heap\serial\fortran\kfacOneThird\";
    rootDir = buildDir + rateModel + "\bin\out";

    zprobFileList = dir(fullfile(rootDir,'zprob_*'));
    zprobFileList = string({zprobFileList(:).name});
    zprobFileListLen = length(zprobFileList);

    z = importdata(fullfile(rootDir,'zgrid.txt'));

    figure; hold on; box on;
    for i = 1:30:zprobFileListLen
        d = importdata(fullfile(rootDir,zprobFileList(i)));
        plot( z.data(:,1) , d.data(:,1) );
    end
    ylabel("Redshift Probability Density Function: \pi ( z )","interpreter","tex","fontSize",13);
    xlabel("Redshift: ( z )","interpreter","tex","fontSize",13);
    title("Redshift PDF of 40 BATSE LGRBs, given " + rateModel + " GRB Rate.");
    hold off;

    xlim([0 7])
    %set(gca,'xscale','log','yscale','linear')

    zstat = importdata(fullfile(rootDir,'batse_zstat.txt'));
    interval50 = zstat.data(:,7) - zstat.data(:,5);
    interval90 = zstat.data(:,8) - zstat.data(:,4);
    disp( rateModel + ": " + string( sprintf('%0.2f',mean(interval50))) + ", " + string( sprintf('%0.2f',mean(interval90)) ) );
    %mean(zstat.data(:,7) ./ zstat.data(:,5))
    %mean(zstat.data(:,8) ./ zstat.data(:,4))

end