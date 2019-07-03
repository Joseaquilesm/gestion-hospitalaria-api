ActiveAdmin.register Analytic do
  permit_params :hemograma, :glicemia, :urea, :creatinina, :alt, :ast, :ggt, :na,
                :k, :mg, :ca, :t4libre, :tsh, :albumina, :hbal, :amonio, :prolactina,
                :hiv, :hcv, :hbsag, :tac_craneo, :ekg, :eeg, :irm_encefalo,
                :espectroscopia, :otros
end
