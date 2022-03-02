
CREATE TABLE patients (
  id INT GENERATED ALWAYS AS IDENTITY,
  UNIQUE (id),
  name VARCHAR NOT NULL,
  date_of_birth DATE NOT NULL
);

CREATE TABLE treatments (
  id INT GENERATED ALWAYS AS IDENTITY,
  UNIQUE (id),
  type VARCHAR NOT NULL,
  name VARCHAR NOT NULL
);

CREATE TABLE medical_histories (
  id INT GENERATED ALWAYS AS IDENTITY,
  admitted_at TIMESTAMP NOT NULL,
  patient_id BIGINT REFERENCES patients(id),
  treatment_id BIGINT REFERENCES treatments(id),
  status VARCHAR NOT NULL,
  CONSTRAINT fk_patient_id FOREIGN KEY(patient_id) REFERENCES patients(id),
  CONSTRAINT fk_treatment_id FOREIGN KEY(treatment_id) REFERENCES treatments(id),
  UNIQUE (patient_id),
  UNIQUE (treatment_id)
);
-- Add Index to Foreign Keys
CREATE INDEX fk_patient_id_medical_histories ON medical_histories(patient_id);
CREATE INDEX fk_treatment_id_medical_histories ON medical_histories(treatment_id);

CREATE TABLE invoices (
  id INT GENERATED ALWAYS AS IDENTITY,
  UNIQUE(id),
  total_amount DECIMAL NOT NULL,
  generated_at TIMESTAMP NOT NULL,
  payed_at TIMESTAMP NOT NULL,
  fk_medical_history_id BIGINT NOT NULL,
  CONSTRAINT fk_medical_history_id FOREIGN KEY (fk_medical_history_id) REFERENCES medical_histories (patient_id),
  UNIQUE(fk_medical_history_id)
);
-- Add Index to foreign keys
CREATE INDEX fk_medical_history_id_index ON invoices (fk_medical_history_id);

CREATE TABLE invoice_items (
  id INT GENERATED ALWAYS AS IDENTITY,
  unit_price DECIMAL NOT NULL,
  quantity INT NOT NULL,
  total_price DECIMAL NOT NULL,
  invoice_id INT,
  treatment_id INT,
  CONSTRAINT fk_invoice_id FOREIGN KEY(invoice_id) REFERENCES invoices(id),
  CONSTRAINT fk_treatment_id FOREIGN KEY(treatment_id) REFERENCES treatments(id),
  UNIQUE(invoice_id, treatment_id)
);

-- Add index to foreign keys
CREATE INDEX fk_invoice_id ON invoice_items (invoice_id);
CREATE INDEX fk_treatment_id ON invoice_items (treatment_id);


--  create a join table between medical_histories and treatments
CREATE TABLE medical_histories_treatments (
  medical_history_id BIGINT REFERENCES medical_histories(id),
  treatment_id BIGINT REFERENCES treatments(id),
  CONSTRAINT fk_medical_history_id FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id),
  CONSTRAINT fk_treatment_id FOREIGN KEY(treatment_id) REFERENCES treatments(id),
  UNIQUE(medical_history_id, treatment_id)
);

-- ADD INDEX To Foreign Keys
CREATE INDEX fk_medical_histories_treatments_medical_history_id_idx ON medical_histories_treatments (medical_history_id);
CREATE INDEX fk_medical_histories_treatments_treatment_id_idx ON medical_histories_treatments (treatment_id);