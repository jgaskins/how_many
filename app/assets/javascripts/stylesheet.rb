module Stylesheet
  module_function

  def selection_list
    {
      display: 'inline-block',
      vertical_align: 'top',
      width: '25%',
    }
  end

  def guess_input
    {
      font_size: '1.5em',
      padding: '0.25em 0.5em',
      width: '3em',
    }
  end

  def go_button
    {
      border: 'none',
      border_radius: '50%',
      background: '#3d2',
      font_size: '1.75em',
      padding: '0.15em 0.25em 0.35em',
    }
  end
end
