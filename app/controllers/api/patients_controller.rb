module Api
  class PatientsController < ApplicationController
    def index
      @people = Person.all
      @patients = Patient.all
      render json: {people: @people, patients: @patients}
    end

    def create
      @person = Person.new(person_params)
      if @person.save
        @patient = Patient.new(patient_params)
        @patient.person = @person
        if @patient.save
          render json: {message: "Patient has successfully been created"}, status: :ok
        else
          render json: {errors: @patient.errors.full_messages}
        end
      else
        render json: {errors: @person.errors.full_messages}
      end
    end

    def show
      @patient = Patient.find_by_id(params[:id])
      if @patient.nil?
        render json: {errors: "Patient does not exist"}
      else
        @person = @patient.person
        render json: {person: @person, patient: @patient}, status: :ok
      end
    end

    def update
      @patient = Patient.find_by_id(params[:id])
      if @patient.nil?
        render json: {errors: "Patient does not exist"}
      else
        @person = @patient.person
        @person.update_attributes(person_params)
        @patient.update_attributes(patient_params)
        render json: {message: "Successfully updated patient's information"}, status: :ok
      end
    end

    def destroy
      render json: {message: "Can't delete patients"}
    end

    private

    def person_params
      params.permit(:identification, :name, :last_name, :address, :phone_number, :genre, :birthday,
                    :birth_place, :nationality, :email, :civil_status, :religion)
    end

    def patient_params
      params.permit(:blood_type, :insured, :insurance_carrier, :insurance_number, :scholarship,
                    :studying, :study_place, :private_education, :working, :working_place,
                    :occupation, :fixed_income, :working_family_members, :working_hours,
                    :housing_type, :cohabitants_number, :home_insurance, :home_insurance_carrier,
                    :recreation_place, :recreation_frequency)
    end
  end
end
