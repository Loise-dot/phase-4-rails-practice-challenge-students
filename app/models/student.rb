class Student < ApplicationRecord
    validates :name , presence: true
    validate :age_validator

    def age_validator
        unless age >= 18
            errors.add(:age , "Age must be >- 18")
        end
    end

    belongs_to :instructor
end