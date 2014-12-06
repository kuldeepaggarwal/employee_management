#/usr/bin/env ruby
designations = ["Certified HIPAA Privacy Associate", "Certified HIPAA Privacy Expert", "Certified HIPAA Privacy Security Expert", "Certified HIPAA Professional", "Certified HIPAA Security Expert", "Certified HIPAA Security Specialist", "Certified Veterinary Assistant", "Doctor of Veterinary Medicine", "Doctor of Chiropractic", "Doctor of Dental Surgery", "Doctor of Medicine", "Doctor of Nursing Practice", "Doctor of Osteopathic Medicine", "Emergency Medical Dispatcher", "Nationally Registered Emergency Medical Responder (Begin January 1, 2012)", "Emergency Medical Technician - Basic (End December 31, 2011)", "Nationally Registered Emergency Medical Technician (Begin January 1, 2012)", "Emergency Medical Technician - Intermediate/85 (End March 31, 2013)", "Emergency Medical Technician - Intermediate/99 (End December 31, 2013)", "Nationally Registered Advanced Emergency Medical Technician (Begin June 1, 2011)", "Emergency Medical Technician - Paramedic (End December 31, 2012)", "Nationally Registered Paramedic (Begin January 1, 2013)", "Licensed Paramedic (Texas)", "Licensed Practical Nurse (much of U.S.) Licensed Vocational Nurse (California and Texas)", "Registered Nurse", "Advanced Practice Nurse Advanced Practice Registered Nurse", "Certified Massage Therapist", "Licensed Massage Therapist", "Licensed Clinical Massage Therapist", "Licensed Midwife", "Certified Midwife", "Certified Professional Midwife", "Certified Nurse-Midwife", "Certified Registered Nurse Anesthetist", "Nurse Practitioner", "Physician Assistant", "Registered Veterinary Technician", "Physical Therapist", "Physical Therapy Assistant", "Medical Laboratory Scientist", "Medical Technologist", "Medical Laboratory Technician", "Licensed Professional Counselor", "Licensed Associate Counselor", "Licensed Master Social Worker", "Licensed Clinical Social Worker", "Licensed Veterinary Technician", "Qualified Clinical Social Worker", "Certified Tissue Bank Specialist", "Certified Hypnotherapist", "National Board Certified Clinical Hypnotherapist", "National Board Certified Clinical Hypnotherapist in Public Service", "National Board Certified Diplomate in Clinical Hypnotherapy", "National Board Certified Diplomate in Clinical Hypnotherapy in Public Service", "National Board Certified Fellow in Clinical Hypnotherapy", "National Board Certified Fellow in Clinical Hypnotherapy in Public Service", "Licensed Acupuncturist", "Diplomate in Acupuncture", "Diplomate in Oriental Medicine", "Fellow of the American Society for Parenteral and Enteral Nutrition", "Fellow of the American Academy of Nursing", "Fellow of the American Society of Health-System Pharmacists", "Fellow of the American Academy of Emergency Medicine", "Fellow of the American Academy of Pediatrics", "Fellow of the American College of Cardiology", "Fellow of the American College of Dentists", "Fellow of the American College of Endocrinology", "Fellow of the American College of Physicians", "Fellow of the American College of Surgeons", "Fellow of the American College of Osteopathic Family Physicians", "Fellow of the American Congress of Obstetricians and Gynecologists", "Doctor of Pharmacy", "Registered Pharmacist", "Registered Respiratory Therapist", "Registered Respiratory Therapist, Neonatal & Pediatric Specialist", "Registered Respiratory Therapist, Sleep Disorder Specialist", "Registered Respiratory Therapist, Adult Critical Care Specialist", "Respiratory practitioner", "Certified Respiratory Therapy Technician", "Certified Respiratory Therapist", "Certified Phlebotomy Technician", "Certified Athletic trainer", "Certified Medical Assistant"]

print 'Pleae enter How many records to be created: '
no_of_records = STDIN.readline.to_i

original_logger, ActiveRecord::Base.logger = ActiveRecord::Base.logger, nil
begin
  puts "\nCreating #{ no_of_records } record(s)..."
  no_of_records.times do
    Employee.create(
      email_id: Faker::Internet.email,
      name: Faker::Name.name,
      age: rand(1..100),
      location: Faker::Address.street_address,
      department: Faker::Commerce.department,
      designation: designations.sample
    )
  end
  puts "#{ Employee.count } record(s) has/have been created."
ensure
  ActiveRecord::Base.logger = original_logger
end