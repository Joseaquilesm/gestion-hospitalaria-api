class CreateAnalytics < ActiveRecord::Migration[5.2]
  def change
    create_table :analytics do |t|
      t.boolean :hemograma
      t.boolean :glicemia
      t.boolean :urea
      t.boolean :creatinina
      t.boolean :alt
      t.boolean :ast
      t.boolean :ggt
      t.boolean :na
      t.boolean :k
      t.boolean :mg
      t.boolean :ca
      t.boolean :t4libre
      t.boolean :tsh
      t.boolean :albumina
      t.boolean :hba1
      t.boolean :amonio
      t.boolean :prolactina
      t.boolean :hiv
      t.boolean :hcv
      t.boolean :hbsag
      t.boolean :tac_craneo
      t.boolean :ekg
      t.boolean :eeg
      t.boolean :irm_encefalo
      t.boolean :espectroscopia
      t.text :others
    end
  end
end
