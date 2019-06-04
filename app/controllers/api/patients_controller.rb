module Api
  class PatientsController < ApplicationController
    def index
      @patients = Patient.all
      @people = Person.all
      render json: {people: @people, patients: @patients}
    end

    def create
      @person = Person.create(person_params)
      @patient = Patient.new(patient_params)
      @patient.person = @person
      @patient.save
      render json: {person: @person, patient: @patient}
    end

    private

    def person_params
      params.permit(:identification,:name,:last_name,:address,:phone_number,:genre,:birthday,
                    :birth_place,:nationality,:email,:civil_status,:religion)
    end

    def patient_params
      params.permit(:blood_type,:insured,:insurance_carrier,:insurance_number,:scholarship,
                    :studying,:study_place,:private_education,:working,:working_place,
                    :occupation,:fixed_income,:working_family_members,:working_hours,
                    :housing_type,:cohabitants_number,:home_insurance,:home_insurance_carrier,
                    :recreation_place,:recreation_frequency)
    end
  end
end
