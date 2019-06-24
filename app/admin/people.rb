ActiveAdmin.register Person do
  permit_params :identification, :name, :last_name, :address, :phone_number, :genre, :birthday,
                :birth_place, :nationality, :email, :civil_status

  form do |f|
    f.inputs do
      f.semantic_errors
      f.input :identification
      f.input :name
      f.input :last_name
      f.input :address
      f.input :phone_number
      f.input :genre, as: :select, collection: ['Masculino', 'Femenino']
      f.input :birthday, as: :datepicker, datepicker_options:
          {
              yearRange: "1950:+nn",
              max_date: "+0D",
              changeYear: true,
              changeMonth: true
          }
      f.input :birth_place
      f.input :nationality
      f.input :email
      f.input :civil_status, as: :select, collection: ['Soltero', 'Casado', 'Viudo']
    end
    f.actions
  end
end
