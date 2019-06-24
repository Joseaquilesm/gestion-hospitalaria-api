class ApiController < ActionController::API
  protected

  def fill_errors(obj, hash)
    obj.each do |attr, msg|
      hash[attr] = msg
    end
  end

  def person_params
    params.permit(:identification, :name, :last_name, :address, :phone_number, :genre, :birthday,
                  :birth_place, :nationality, :email, :civil_status)
  end
end
