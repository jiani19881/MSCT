function [clf,tran_particles] = caculateWeight_r(posx,negx,particles)
num_particles=size(particles,2);
tran_particles=particles;
samples_feature=[];
for j = 1:num_particles
    samples_feature=[samples_feature particles(j).v50];
end
r = ratioClassifier(posx,negx,samples_feature);
clf = sum(r);% linearly combine the ratio classifiers in r to the final classifier
eclf=exp(clf);
tmpclf=sum(eclf);normclf=eclf/tmpclf;
for j = 1:num_particles
    tran_particles(j).w=normclf(j);
end