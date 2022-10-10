class LastLetterCapitalValidator < ActiveModel::EachValidator
  def validate_each(record, attr, value)
    record.errors.add attr, 'Last letter must be capitaL' unless value.end_with?(value[-1].upcase) 
  end
end
