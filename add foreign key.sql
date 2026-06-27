alter table appointments																
add constraint fist_fk
foreign key (doctor_id) references doctors(doctor_id);  

alter table bills
add constraint second_fk
foreign key (patient_id) references patientes(patient_id);

alter table appointments
add constraint third_fk 
foreign key (patient_id) references patientes(patient_id);

alter table bills
add constraint fort_fk
foreign key (medicine_id) references medicines(medicine_id);