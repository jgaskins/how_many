module Stylesheet
  module_function

  def selection_list
    @selection_list ||= {
      display: 'inline-block',
      vertical_align: 'top',
      width: '25%',
    }
  end
end
