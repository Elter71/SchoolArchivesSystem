class UserValidator < ActiveModel::Validator
  def validate(record)
    if first_and_last_name_empty(record)
      record.errors.add(:base,"Imię i nazwisko nie może być pustę.")
    end
  end

  private
  def first_and_last_name_empty(record)
    record.first_name.blank? ||  record.last_name.blank?
  end
end