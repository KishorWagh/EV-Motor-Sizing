%PROJECT_POWER_SIZING
clear all;
clc;

%Input_variables
Kerb_Weight=1000%(kg)
Payload=500%(kg)
Coefficient_of_rolling_resistance=0.012
Air_density=1.225%(kg/m^3)
Frontal_area=1.8%(m^2)
Drag_coefficient_=0.2
grade_angle=0.2%radiance
%drive_cycle_input
Driving_cycle=readtable('DRIVE_CYCLE-EUDC.xlsx')
Time=Driving_cycle{:,1};
Velocity=Driving_cycle{:,2}
VelocityInMeters=0
Energy = 0


%Govering_equation
for i=1:1370
    VelocityInMeters(i) = Velocity(i)* 1609
    R_rolling(i)=(Payload+Kerb_Weight)*Coefficient_of_rolling_resistance*9.81
    R_air(i)=0.5*Air_density*Frontal_area*Drag_coefficient_*VelocityInMeters(i)*VelocityInMeters(i) 
    R_grade(i)=(Payload+Kerb_Weight)*9.81*sin(grade_angle)

    %Total_resistance
    total_resistance(i)=R_rolling(i)+R_air(i)+R_grade(i)

    Power(i)=total_resistance(i)*VelocityInMeters(i)
    Energy(i) = Power(i)*Time(i)
end

figure
plot(Time,R_rolling,'linewidth',2)
hold on
plot(Time,R_grade,'linewidth',2)
hold on
plot(VelocityInMeters,R_air,'linewidth',2)
hold on
plot(VelocityInMeters,total_resistance,'linewidth',2)
hold on
plot(VelocityInMeters,Power,'linewidth',2)
hold on
plot(VelocityInMeters,Energy,'linewidth',2)
hold on
plot(Time,VelocityInMeters,'linewidth',2)
hold on




%plot
%1plot time vs velocity
%rolling vs velocity
%air_resistance vs velocity
%grade_resistance vs velocity
%total_resistance vs velocity
%power(w) vs velocity