class Profile < ApplicationRecord
    belongs_to :user

    with_options if: :active_or_general? do |profile|
        profile.validates :first_name, :last_name, :age, :email, presence: true
    end

    with_options if: :active_or_educational? do |profile|
        profile.validates :university, :level_of_education, :cgpa, presence: true
    end

    with_options if: :active_or_professional? do |profile|
        profile.validates :job_title, :company, presence: true
    end

    def active?
        status == 'active'
    end

    def active_or_general?
        status&.include?('general') || active?
    end

    def active_or_educational?
        status&.include?('educational') || active?
    end

    def active_or_professional?
        status&.include?('professional') || active?
    end
end
