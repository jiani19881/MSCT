% Demo for paper "Real-time multi-scale tracking based on compressive sensing,"Yunxia Wu, Ni Jia and Jiping Sun
% To appear in The Visual Computer,2014-4-30 (doi:10.1007/s00371-014-0942-5)
% Implemented by Ni Jia, School of Mechanical Electronic and Information Engineering, China University of Mining and Technology, Beijing.
% Email: jiani19881@163.com
% Date: 11/31/2013
% Note:The feedback strategy for occluded have not been included in this version.
% Thanks for the codes provided by Kaihua Zhang for paper "Real-Time Compressive Tracking"
clc;clear all;close all;
rand('state',0);
addpath('./data');
load init.txt;
initstate = init;
img_dir = dir('./data/*.png');
img = imread(img_dir(1).name);
img = double(img(:,:,1));
lRate = 0.9;
trparams.init_negnumtrain = 50;%number of trained negative samples
trparams.init_postrainrad = 4.0;%radical scope of positive samples
trparams.initstate = initstate;% object position [x y width height]
% trparams.srchwinsz = 20;% size of search window
%-------------------------
% classifier parameters
clfparams.width = trparams.initstate(3);
clfparams.height= trparams.initstate(4);
%-------------------------
% feature parameters
% number of rectangle from 2 to 4.
ftrparams.minNumRect = 2;
ftrparams.maxNumRect = 4;
%-------------------------
M = 150;% number of all weaker classifiers, i.e,feature pool
%-------------------------
posx.mu = zeros(M,1);% mean of positive features
negx.mu = zeros(M,1);
posx.sig= ones(M,1);% variance of positive features
negx.sig= ones(M,1);
%-------------------------
%compute feature template
[ftr.px,ftr.py,ftr.pw,ftr.ph,ftr.pwt] = HaarFtr(clfparams,ftrparams,M);
% load feature1
%-------------------------
%compute sample templates
posx.sampleImage = sampleImg(img,initstate,trparams.init_postrainrad,0,100000);
negx.sampleImage = sampleImg(img,initstate,1.5*20,4+trparams.init_postrainrad,50);
%-----------------------------------
%--------Feature extraction
iH = integral(img);%Compute integral image
posx.feature = getFtrVal(iH,posx.sampleImage,ftr);
negx.feature = getFtrVal(iH,negx.sampleImage,ftr);
%--------------------------------------------------
[posx.mu,posx.sig,negx.mu,negx.sig] = classiferUpdate(posx,negx,posx.mu,posx.sig,negx.mu,negx.sig,lRate);% update distribution parameters
%-------------------------------------------------
num = length(img_dir);% number of frames
%--------------------------------------------------------
x = initstate(1);% x axis at the Top left corner
y = initstate(2);
w = initstate(3);% width of the rectangle
h = initstate(4);% height of the rectangle
%--------------------------------------------------------
%initialize the scale
xdirScale=1;ydirScale=1;
%initialization of particles
[imgHeight,imgWidth]=size(img);
samples.sx = x;samples.sy = y;samples.sw = w;samples.sh = h;
initFeature=getFtrVal(iH,samples,ftr);%Feature of current rectangle box
num_particles=200;%particles number.
particles= init_distribution( initstate,num_particles,initFeature);%initialization of particles
showAll=0;%control whether all particles will be shown or not.
for i = 2:num
    img = imread(img_dir(i).name);
    imgSr = img;% imgSr is used for showing tracking results.
    img = double(img(:,:,1));
    iH = integral(img);%Compute integral image
    %2-order transition model: transition of all particles.
	particles = transition_2order(particles,imgWidth, imgHeight);
    tmpPart=particles;
    %Feature extraction for all particles.Included scale information for each particle
    particles=caculateV50(particles,iH,ftr);
    [clf,particles] = caculateWeight_r(posx,negx,particles);%computer weight for each particle
    
    [SortClf,Ix]=sort(clf,'descend');
    sort_particles=particles(Ix);%sort partcles
    %-------------------------------------
    [c,index] = max(clf);
    initstate=getRect(particles(index));%determine the tracking result of current frame.(location)
    xdirScale=particles(index).s;ydirScale=xdirScale;%determine the tracking result of current frame.(scale)
    
    particles = resample(sort_particles, num_particles);%particle resample.
    %-Show the tracking results
    figure(1);imshow(uint8(imgSr));
    if showAll==1
        for tt=1:num_particles
            particlePos=getRect(tmpPart(tt));
            rectangle('Position',particlePos,'LineWidth',1,'EdgeColor','y');
        end
    end
    rectangle('Position',initstate,'LineWidth',4,'EdgeColor','r');
    hold on;
    text(5, 18, strcat('#',num2str(i)), 'Color','y', 'FontWeight','bold', 'FontSize',20);
    set(gca,'position',[0 0 1 1]); 
    pause(0.00001); 
    hold off;
    %Extract samples  
    posx.sampleImage = sampleImg(img,initstate,trparams.init_postrainrad,0,100000);%*xdirScale
    negx.sampleImage = sampleImg(img,initstate,1.5*20,4+trparams.init_postrainrad,trparams.init_negnumtrain);%*xdirScale
    %Update all the features
    disp(['The current scale of target:' num2str(xdirScale)]);
    posx.feature = getFtrVal_includeScale(iH,posx.sampleImage,ftr,xdirScale,ydirScale);
    negx.feature = getFtrVal_includeScale(iH,negx.sampleImage,ftr,xdirScale,ydirScale);
    [posx.mu,posx.sig,negx.mu,negx.sig] = classiferUpdate(posx,negx,posx.mu,posx.sig,negx.mu,negx.sig,lRate);% update distribution parameters
end