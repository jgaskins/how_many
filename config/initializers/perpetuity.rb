env = if defined? Rails
        Rails.env
      else
        'test'
      end

Perpetuity.data_source ENV.fetch('DATABASE_URL') { "postgres://localhost/how_many_#{env}" }
