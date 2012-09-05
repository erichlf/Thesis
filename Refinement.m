h(1)=1/2;
model=SQGE; %run the model for the initial mesh

%calculate errors
[e_2(1) e_H1(1) e_H2(1)]=errors(model); 

for i=2:5
  h(i)=1/2^i;
  %refine mesh
  model.mesh('mesh1').feature.create(ref,'Refine');
  model.mesh('mesh1').run;
  %run model
  model.study('std1').run;

  %calculate errors
  [e_2(i) e_H1(i) e_H2(i)]=errors(model);
end

%function to calculate the L^2, H^1, and H^2 errors
function [e_2 e_H1 e_H2]=errors(model)

  e_2=sqrt(mphint(model,'(u-u_exact)^2'));
  e_H1=sqrt(mphint(model,'(u-u_exact)^2+(ux-ux_exact)^2+(uy-uy_exact)^2'));
  e_H2=sqrt(mphint(model,'(u-u_exact)^2+(ux-ux_exact)^2+(uy-uy_exact)^2+(uxx-uxx_exact)^2+(uxy-uxy_exact)^2+(uyy-uyy_exact)^2'));

end
