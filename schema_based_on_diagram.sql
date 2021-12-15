create table patients (
id int primary key generated always as IDENTITY,
name varchar(100) not null,
date_of_birth date);

create table medical_histories(
id int primary key generated always as IDENTITY,
admitted_at timestamp,
patient_id int,
status varchar(50) not null,
constraint patient_id foreign key(patient_id) references patients(id)
);


create table invoices (
id int primary key generated always as IDENTITY,
total_amount decimal,
generated_at timestamp,
payed_at timestamp,
medical_history_id int,
constraint medical_history_id foreign key(medical_history_id) references medical_histories(id));


create table treatments (
id int primary key generated always as IDENTITY,
type varchar(100) not null,
name varchar(100) not null
);

create table invoice_items(
id int primary key generated always as IDENTITY,
unit_price decimal not null,
quantity int not null,
total_price decimal not null,
invoice_id int,
treatment_id int,
constraint invoice_id foreign key(invoice_id) references invoices(id),
constraint treatment_id foreign key(treatment_id) references treatments(id)
);

CREATE TABLE medical_treatments (
  medical_history_id INT,
  treatment_id INT,
  CONSTRAINT fk_medical_histories
    FOREIGN KEY(medical_history_id)
      REFERENCES medical_histories(id),
  CONSTRAINT fk_treatments
    FOREIGN KEY(treatment_id)
      REFERENCES treatments(id)
);

CREATE INDEX patient_id ON medical_histories(patient_id);
CREATE INDEX medical_history_id ON invoices(medical_history_id);
CREATE INDEX invoice_id ON invoice_items(invoice_id);
CREATE INDEX treatment_id ON invoice_items(treatment_id); 